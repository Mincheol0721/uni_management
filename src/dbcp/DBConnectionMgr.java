
package dbcp;

import java.sql.*;
import java.util.Properties;
import java.util.Vector;

/*
(개발자가 이미 만들어놓은 DBCP(커넥션 풀) DBConnectionMgr.java 파일 설명) 

DBConnectionMgr.java 중요 3가지 메소드 : 
//1.getInstance() : DBCP(풀)객체 위치를 알아내기.
//2.getConnection() : DB연결 객체 꺼내서 빌려오기.
//3.freeConnection() : 사용한 DB커넥션객체 반납(해제). 

*/
public class DBConnectionMgr {
	
	/*DB연결 커넥션 객체 10개 생성*/
	private Vector connections = new Vector(10);
    
    /********DB접속정보 수정*********/
    private String _driver = "com.mysql.jdbc.Driver",
    _url = "jdbc:mysql://localhost:3306/studyplannerdb",
    _user = "root",
    _password = "0000";
    /****************************/
    
    private boolean _traceOn = false;
    private boolean initialized = false;
    private int _openConnections = 10;
    
   //싱글톤 패턴 : 객체를 단하나만 생성할수 있는 디자인 패턴   static으로 지정함!
    /*커넥션 풀 객체를 단하나만 생성하여 담을 변수*/
    private static DBConnectionMgr instance = null; 

    //생성자
    public DBConnectionMgr() {
    }

    //1.getInstance() : DBCP(풀)객체 위치를 알아내기.
    //2.getConnection() : DB연결 객체 꺼내서 빌려오기.
    //3.freeConnection() : 사용한 DB커넥션객체 반납(해제). 
    

    /*커넥션 풀 객체 리턴 메소드*/
    //1.단! 하나의 커넥션 풀 객체를 생성하여  리턴하는 메소드  
    public static DBConnectionMgr getInstance() {
    	if (instance == null) {
            synchronized (DBConnectionMgr.class) {
                if (instance == null) {
                    instance = new DBConnectionMgr();
                }
            }
        }

        return instance; //커넥션 풀생성하여  리턴
    }
    
    /*커넥션 객체 반환 메소드*/
    //2. 커넥션 풀 객체 안에  미리만들어 놓은  DB연결 커넥션 객체 반환  메소드 
    public synchronized Connection getConnection()
            throws Exception {
        
    	if (!initialized) {
        	
        	//드라이버 를 JDBC프로그램에 로딩
            Class c = Class.forName(_driver);
            
            //DB연결
            DriverManager.registerDriver((Driver) c.newInstance());

            initialized = true;
        }


        Connection c = null;
        ConnectionObject co = null;
        boolean badConnection = false;


        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.elementAt(i);

            // If connection is not in use, test to ensure it's still valid!
            if (!co.inUse) {
                try {
                    badConnection = co.connection.isClosed();
                    if (!badConnection)
                        badConnection = (co.connection.getWarnings() != null);
                } catch (Exception e) {
                    badConnection = true;
                    e.printStackTrace();
                }

                // Connection is bad, remove from pool
                if (badConnection) {
                    connections.removeElementAt(i);
                    trace("ConnectionPoolManager: Remove disconnected DB connection #" + i);
                    continue;
                }

                c = co.connection;
                co.inUse = true;

                trace("ConnectionPoolManager: Using existing DB connection #" + (i + 1));
                break;
            }
        }

        if (c == null) {
            c = createConnection();
            co = new ConnectionObject(c, true);
            connections.addElement(co);

            trace("ConnectionPoolManager: Creating new DB connection #" + connections.size());
        }

        return c;
    }
    
    
    /*자원사용 후 반납 메소드*/
    /*3.커넥션 객체를  커넥션 풀 공간으로 반납하는 메소드!    오버로딩 되어 있다.*/
    public synchronized void freeConnection(Connection c) {
        if (c == null)
            return;

        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.elementAt(i);
            if (c == co.connection) {
                co.inUse = false;
                break;
            }
        }

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.elementAt(i);
            if ((i + 1) > _openConnections && !co.inUse)
                removeConnection(co.connection);
        }
    }

    public void freeConnection(Connection c, PreparedStatement p, ResultSet r) {
        try {
            if (r != null) r.close();
            if (p != null) p.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, Statement s, ResultSet r) {
        try {
            if (r != null) r.close();
            if (s != null) s.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, PreparedStatement p) {
        try {
            if (p != null) p.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, Statement s) {
        try {
            if (s != null) s.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    

    public void setOpenConnectionCount(int count) {
        _openConnections = count;
    }


    public void setEnableTrace(boolean enable) {
        _traceOn = enable;
    }


    /** Returns a Vector of java.sql.Connection objects */
    public Vector getConnectionList() {
        return connections;
    }


    /** Opens specified "count" of connections and adds them to the existing pool */
    public synchronized void setInitOpenConnections(int count)
            throws SQLException {
        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < count; i++) {
            c = createConnection();
            co = new ConnectionObject(c, false);

            connections.addElement(co);
            trace("ConnectionPoolManager: Adding new DB connection to pool (" + connections.size() + ")");
        }
    }


    /** Returns a count of open connections */
    public int getConnectionCount() {
        return connections.size();
    }

    




    /** Marks a flag in the ConnectionObject to indicate this connection is no longer in use */
    public synchronized void removeConnection(Connection c) {
        if (c == null)
            return;

        ConnectionObject co = null;
        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.elementAt(i);
            if (c == co.connection) {
                try {
                    c.close();
                    connections.removeElementAt(i);
                    trace("Removed " + c.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }

                break;
            }
        }
    }


    private Connection createConnection()
            throws SQLException {
        Connection con = null;

        try {
            if (_user == null)
                _user = "";
            if (_password == null)
                _password = "";

            Properties props = new Properties();
            props.put("user", _user);
            props.put("password", _password);

            con = DriverManager.getConnection(_url, props);
        } catch (Throwable t) {
            throw new SQLException(t.getMessage());
        }

        return con;
    }


    /** Closes all connections and clears out the connection pool */
    public void releaseFreeConnections() {
        trace("ConnectionPoolManager.releaseFreeConnections()");

        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.elementAt(i);
            if (!co.inUse)
                removeConnection(co.connection);
        }
    }


    /** Closes all connections and clears out the connection pool */
    public void finalize() {
        trace("ConnectionPoolManager.finalize()");

        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.elementAt(i);
            try {
                co.connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            co = null;
        }

        connections.removeAllElements();
    }


    private void trace(String s) {
        if (_traceOn)
            System.err.println(s);
    }

}


class ConnectionObject {
    public java.sql.Connection connection = null;
    public boolean inUse = false;

    public ConnectionObject(Connection c, boolean useFlag) {
        connection = c;
        inUse = useFlag;
    }
}

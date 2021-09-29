from psycopg2.extras import execute_values


def execute_select_query(query,connection):
    """This is the method to execute the select sql query given the parameter the query and connection method"""
    try:
        conn=connection
        #print(conn)
        cur=conn.cursor()
        cur.execute(query)
        data=cur.fetchall()

    except(Exception) as e:
        print(e)
    finally:
        if(conn):
            cur.close()
            conn.close()
            return data

def execute_bulk_insert(query,connection,data):
    
    try:
        cursor = connection.cursor()

        
        data=[[str(ele) for ele in item.values()] for item in data]
        
        execute_values(
        cursor, query,data)

        connection.commit()
        print(query , "sucessfull")
    except(Exception) as e:
        print(e)
    finally:
        if(connection):
            cursor.close()
            connection.close()
            print("connection closed")



def execute_insert_query(query,connection,data):
    """This is the method to execute the insert sql query given the parameter the query and connection method and data"""

    try:
        conn=connection
        cur=conn.cursor()
        for item in data:
            cur.execute(query,tuple(item))
        conn.commit()
        print(query+",Sucessfully inserted data")
    except(Exception) as e:
        print(e)
    finally:
        if(conn):
            cur.close()
            conn.close()




def execute_delete_query(query,connection):
    """This is the method which deletes the table contents"""
    
    try:
        conn=connection
        cur=conn.cursor()
        cur.execute(query)
        conn.commit()
        print(query+",Sucessfully deleted data from sales table of sales_raw")
    except(Exception) as e:
        print(e)
    finally:
        if(conn):
            cur.close()
            conn.close()
from flask import Flask, render_template, request, session
from flask_mysqldb import MySQL

app = Flask(__name__)
current_time = time.time() #we will use this as part of our session

#the information for the database. This is used to authenticate the database
app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'rit_directory'

from flask import session
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

mysql = MySQL(app)

@app.route("/", methods=['GET', 'POST'])  # this sets the route to this page
def home():
    if request.method == 'GET':
        users = []
	    
    else:
        name = request.form['name']
        name = name.lower()
        cursor = mysql.connection.cursor()
        query = f"""
        SELECT username, first_name, last_name
        FROM directory
        JOIN user ON directory.user_id = user.id
        WHERE LOWER(first_name) = '{name}' OR LOWER(last_name) = '{name}';
        """
        cursor.execute(query)

        users = cursor.fetchall()


    return render_template("home.html", people = users)

@app.route("/admin",methods=['GET', 'POST'])
def admin():
    data = []
    current_user = session['user']
    error = ""

    #user attempting to login
    if request.method == "POST":
        username = request.form['username']
        password = request.form['password']

        #query the database to see if the username and password matched.
        #this query is not vulnerable to sql injection
        query = f"""
            SELECT username, password from user where username = ? and password = ?
        """
        cursor.execute(query,(username, password))
        data = cursor.fetchall()

        #if we have some result then we set the user session
        #this will mark them as logged in
        if len(data) > 0:
            session['user'] = current_time

            #now we need to get the full sensitive data including home address
            query = """
            SELECT * from directory JOIN user ON directory.user_id = user.id
            """
            cursor.execute(query)
            data = cursor.fetchall()

        else:
            session['user'] = None
            error = "Invalid username or password!"
    
    return render_template('admin.html', error = error, info = data)
        
    

if __name__ == "__main__":
    app.run()
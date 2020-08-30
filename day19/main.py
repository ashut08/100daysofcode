from flask import  Flask, render_template
from registeration import RegForm


app = Flask(__name__)
app.config['SECRET_KEY']='d35604163ea17368193d893066d9328a'
@app.route("/register")
def register():
    form=RegForm()
    return render_template('register.html',title='Registration',form=form)



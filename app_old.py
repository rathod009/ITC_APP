from flask import Flask, request, jsonify
import pyodbc
from flask_cors import CORS
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)
CORS(app)

# SQL Server Connection Configuration (REPLACE WITH YOUR CREDENTIALS)
SERVER = 'DESKTOP-EP7PF1F\\SQLEXPRESS'  # Or your server address
DATABASE = 'itc-app'
USERNAME = ''  # Your username
PASSWORD = ''  # Your password

try:
    connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
    cursor = connection.cursor()
    print("Successfully connected to itc-app database")
except Exception as e:
    logging.exception(f"An error occurred: {e}")
    print(f"Error connecting to itc-app database: {e}")
    exit()

def create_database_and_table():
    try:
        cursor.execute("IF NOT EXISTS(SELECT * FROM sys.databases WHERE name='itc-app') CREATE DATABASE [itc-app]")
        connection.commit()
        print("itc-app database created or already exists")

        cursor.execute("USE [itc-app]")

        # Check if the Inquiries table exists
        cursor.execute("IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Inquiries') BEGIN CREATE TABLE Inquiries ( ID INT IDENTITY(1,1) PRIMARY KEY, FullName VARCHAR(255), Gender VARCHAR(50), Mobile VARCHAR(20), Email VARCHAR(255), country VARCHAR(255), state VARCHAR(255), city VARCHAR(255), personType VARCHAR(255), highestEducation VARCHAR(255), priorKnowledge VARCHAR(255), KnowITCFrom VARCHAR(255), InquiryDate DATETIME, InterestedCoursesCategory VARCHAR(MAX), inquiryType VARCHAR(255)) END")
        connection.commit()
        print("Inquiries table created or already exists")

    except Exception as e:
        print(f"Error creating database or table: {e}")
        connection.rollback()

        cursor.execute("""
            CREATE TABLE Inquiries (
                ID INT IDENTITY(1,1) PRIMARY KEY,
                FullName VARCHAR(255),
                Gender VARCHAR(50),
                Mobile VARCHAR(20),
                Email VARCHAR(255),
                country VARCHAR(255),
                state VARCHAR(255),
                city VARCHAR(255),
                personType VARCHAR(255),
                highestEducation VARCHAR(255),
                priorKnowledge VARCHAR(255),
                KnowITCFrom VARCHAR(255),
                InquiryDate DATETIME,
                InterestedCoursesCategory VARCHAR(MAX),
                inquiryType VARCHAR(255)
            )
        """)
        connection.commit()
        print("Inquiries table created")

    except Exception as e:
        print(f"Error creating database or table: {e}")
        connection.rollback()

create_database_and_table()


@app.route('/submitInquiry', methods=['POST'])
def submit_inquiry():
    try:
        data = request.get_json()
        logging.debug(f"Received data: {data}")

        f_name = data.get('fName') or ""
        l_name = data.get('lName') or ""
        full_name = (f_name + " " + l_name).strip()
        gender = data.get('gender') or ""
        mobile = data.get('mobile') or ""
        email = data.get('email') or ""
        country = data.get('country') or ""
        state = data.get('state') or ""
        city = data.get('city') or ""
        person_type = data.get('personType') or ""
        highest_education = data.get('highestEducation') or ""
        prior_knowledge = data.get('priorKnowledge') or ""
        know_itc_from = data.get('knowITCFrom') or ""
        inquiry_date = data.get('inquiryDate') or ""
        interested_courses = ', '.join(data.get('interestedCoursesCategory', []))  # Handle empty list case
        inquiry_type = data.get('inquiryType') or ""

        query = """
            INSERT INTO Inquiries (FullName, Gender, Mobile, Email, country, state, city, personType, highestEducation, priorKnowledge, KnowITCFrom, InquiryDate, InterestedCoursesCategory, inquiryType)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        """
        values = (full_name, gender, mobile, email, country, state, city, person_type, highest_education, prior_knowledge, know_itc_from, inquiry_date, interested_courses, inquiry_type)

        cursor.execute(query, values)
        connection.commit()

        return jsonify({'status': 'success', 'message': 'Inquiry submitted'}), 200

    except Exception as e:
        logging.exception(f"Error during submission: {e}")
        connection.rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500


@app.route('/getInquiry/<int:inquiry_id>', methods=['GET'])
def get_inquiry(inquiry_id):
    try:
        query = "SELECT * FROM Inquiries WHERE ID = ?"
        cursor.execute(query, (inquiry_id,))
        row = cursor.fetchone()

        if row is None:
            return jsonify({'status': 'error', 'message': 'Inquiry not found'}), 404

        print("Row from database:", row)

        full_name = row.FullName if row.FullName else ""
        name_parts = full_name.split()
        f_name = name_parts[0] if name_parts else ""  # Correctly get the first name
        l_name = name_parts[1] if len(name_parts) > 1 else ""  # Correctly get the last name

        inquiry_data = {
            'ID': row.ID,
            'fName': f_name,
            'lName': l_name,
            'gender': row.Gender or "",
            'mobile': str(row.Mobile) if row.Mobile else "",  # Convert to string
            'email': row.Email or "",
            'country': row.country or "",
            'state': row.state or "",
            'city': row.city or "",
            'personType': row.personType or "",
            'highestEducation': row.highestEducation or "",
            'priorKnowledge': row.priorKnowledge or "",
            'knowITCFrom': row.KnowITCFrom or "",
            'inquiryType': row.inquiryType or "",
            'inquiryDate': row.InquiryDate.strftime('%Y-%m-%d %H:%M:%S') if row.InquiryDate else "",
            'interestedCoursesCategory': row.InterestedCoursesCategory.split(', ') if row.InterestedCoursesCategory else [],
        }

        print("Inquiry data:", inquiry_data)

        return jsonify({'status': 'success', 'data': inquiry_data})

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500


@app.route('/updateInquiry/<int:inquiry_id>', methods=['PUT'])
def update_inquiry(inquiry_id):
    try:
        data = request.get_json()

        query = "UPDATE Inquiries SET "
        updates = []
        values = []

        for key, value in data.items():
            if key == 'interestedCoursesCategory':
                value = ', '.join(value)  # Join the list for the database

            if key != 'ID':
                updates.append(f"{key} = ?")
                values.append(value)

        query += ", ".join(updates)
        query += " WHERE ID = ?"
        values.append(inquiry_id)

        cursor.execute(query, values)
        connection.commit()

        return jsonify({'status': 'success', 'message': 'Inquiry updated'}), 200

    except Exception as e:
        connection.rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
    
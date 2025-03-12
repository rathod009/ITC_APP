from flask import Flask, jsonify, request
from flask_cors import CORS
import pyodbc
import logging
from datetime import datetime

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)
CORS(app)

# Course Data API
courses = [
    {
        'title': 'Accounting',
        'description': 'Learn accounting principles, financial analysis, and budgeting. Build a foundation for a finance career.',
        'imageUrl': 'assets/images/accounting.png'
    },
    {
        'title': 'Artificial Intelligence',
        'description': 'Implement AI solutions, automate tasks, and optimize processes. Drive efficiency with intelligent technology.',
        'imageUrl': 'assets/images/artificial.webp'
    },
    {
        'title': 'Autodesk',
        'description': 'Master Autodesk software for 2D/3D modeling in architecture and engineering. Prepare for industry certifications.',
        'imageUrl': 'assets/images/autodesk.png'
    },
    {
        'title': 'Ethical Hacking',
        'description': 'Study cryptography, network protocols, and ethical hacking methodologies. Become a guardian of data integrity.',
        'imageUrl': 'assets/images/ethical_hacking.jpg'
    },
    {
        'title': 'Hardware',
        'description': 'Gain hardware knowledge: CPUs, motherboards, memory. Learn to assemble and repair systems for IT careers.',
        'imageUrl': 'assets/images/hardware.jpg'
    },
    {
        'title': 'Multimedia',
        'description': 'Unleash your creativity through the power of multimedia. Develop your skills in graphics and video editing.',
        'imageUrl': 'assets/images/multimedia.png'
    },
    {
        'title': 'Cloud Computing & Networking',
        'description': 'Learn networking concepts, security, and administration. Configure routers and switches for network careers.',
        'imageUrl': 'assets/images/networking.png'
    },
    {
        'title': 'Data Analytics & Office Automation',
        'description': 'Master Microsoft Office Suite for document creation, data analysis, and presentations in office environments.',
        'imageUrl': 'assets/images/data_analytics.png'
    },
    {
        'title': 'Programming',
        'description': 'Learn programming languages like Python and Java. Develop skills in software and app development.',
        'imageUrl': 'assets/images/programming.png'
    },
    {
        'title': 'Spoken English',
        'description': 'Improve spoken English: pronunciation, grammar, vocabulary. Practice for presentations and interviews.',
        'imageUrl': 'assets/images/spoken_english.png'
    },
    {
        'title': 'Internship',
        'description': 'Gain practical experience through internships. Apply skills in real-world settings and build your network.',
        'imageUrl': 'assets/images/internship.jpg'
    },
    {
        'title': 'Other',
        'description': 'Explore specialized courses like data science and web development. Learn emerging technologies.',
        'imageUrl': 'assets/images/other.png'
    },
]

@app.route('/courses', methods=['GET'])
def get_courses():
    return jsonify(courses)

# Database Inquiry API
SERVER = 'lmsserver-sql.itcmogri.org'
DATABASE = 'ITC'
USERNAME = 'itc-app'
PASSWORD = 'AnoopaM@143'

try:
    connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
    cursor = connection.cursor()
    print("Successfully connected to ITC database")
except Exception as e:
    logging.exception(f"An error occurred: {e}")
    print(f"Error connecting to ITC database: {e}")
    exit()

@app.route('/submitInquiry', methods=['POST'])
def submit_inquiry():
    connection = None
    try:
        connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
        cursor = connection.cursor()
        data = request.get_json()
        logging.debug(f"Received data: {data}")
        f_name = data.get('fName') or ""
        l_name = data.get('lName') or ""
        full_name = (f_name + " " + l_name).strip()
        gender = data.get('gender') or ""
        mobile = data.get('mobile') or ""
        email = data.get('email') or ""
        city = data.get('city') or ""
        person_type = data.get('personType') or ""
        highest_education = data.get('highestEducation') or ""
        prior_knowledge = data.get('priorKnowledge') or ""
        know_itc_from = data.get('knowITCFrom') or ""
        inquiry_date = data.get('inquiryDate') or ""
        interested_courses = ', '.join(data.get('interestedCoursesCategory', []))
        inquiry_type = data.get('inquiryType') or ""

        # Convert inquiry_date to datetime
        try:
            inquiry_date_obj = datetime.strptime(inquiry_date, '%Y-%m-%dT%H:%M:%S.%f')  # Adjusted format string.
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Invalid date format'}), 400

        # Find the maximum existing PersonId
        max_person_id_query = "SELECT MAX(PersonId) FROM [ITC].dbo.a_InquiryPersonMaster"
        cursor.execute(max_person_id_query)
        max_person_id = cursor.fetchone()[0] or 0
        new_person_id = max_person_id + 1

        # Insert into a_InquiryPersonMaster
        person_query = """
            INSERT INTO [ITC].dbo.a_InquiryPersonMaster (PersonId, Name, Gender, Mobile, Email, City, PersonType, PersonQualification)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        person_values = (new_person_id, full_name, gender, mobile, email, city, person_type, highest_education)  # Cast person_type to int.
        cursor.execute(person_query, person_values)

        # Find the maximum existing InquiryId
        max_inquiry_id_query = "SELECT MAX(InquiryId) FROM [ITC].dbo.a_InquiryMaster"
        cursor.execute(max_inquiry_id_query)
        max_inquiry_id = cursor.fetchone()[0] or 0
        new_inquiry_id = max_inquiry_id + 1

        # Insert into a_InquiryMaster
        inquiry_query = """
            INSERT INTO [ITC].dbo.a_InquiryMaster (InquiryId, PersonId, InquiryDate, CourseCategory, PriorKnowledge, KnowITCFrom, InquiryType, InquiredBy)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        inquiry_values = (new_inquiry_id, new_person_id, inquiry_date_obj, interested_courses, prior_knowledge, know_itc_from, inquiry_type, 'application')
        cursor.execute(inquiry_query, inquiry_values)

        connection.commit()
        return jsonify({'status': 'success', 'message': 'Inquiry submitted'}), 200

    except Exception as e:
        logging.exception(f"Error during submission: {e}")
        if connection:
            connection.rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500
    finally:
        if connection:
            connection.close()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
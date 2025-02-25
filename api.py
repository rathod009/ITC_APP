from flask import Flask, jsonify
from flask_cors import CORS #Import CORS

app = Flask(__name__)
CORS(app) #Enable CORS

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
    # Add the rest of your course data here
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

if __name__ == '__main__':
    app.run(debug=True) #debug=True is for development, remove it for production.
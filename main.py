import json
from jinja2 import Environment, FileSystemLoader


# קריאת קובץ הקונפיגורציה JSON
def load_config(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)


# פונקציה שמייצרת קוד SV על בסיס תבנית Jinja2
def generate_sv_code(config, template_path, output_path):
    # טוען את התבנית ממערכת הקבצים
    env = Environment(loader=FileSystemLoader('templates'))
    template = env.get_template(template_path)

    # הפקת הקוד מתוך התבנית על בסיס ההגדרות
    rendered_code = template.render(config)

    # שמירת הקוד שנוצר לקובץ פלט
    with open(output_path, 'w') as f:
        f.write(rendered_code)
    print(f"SV code generated and saved to {output_path}")


# מסלול לקובץ הקונפיגורציה
config_file = 'config.json'
# שם התבנית (שנמצאת בתקיית 'templates')
template_file = 'sv_temp.sv'
# שם קובץ הפלט
output_file = 'output.sv'

# קריאה והפעלת הסקריפט
if __name__ == "__main__":
    config = load_config(config_file)  # טוען את הקונפיגורציה
    generate_sv_code(config, template_file, output_file)  # מפיק את קובץ ה-SV

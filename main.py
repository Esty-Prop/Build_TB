import json
import os
from jinja2 import Environment, FileSystemLoader

# Read the JSON configuration file
def load_config(config_file):
    with open(config_file, 'r') as f:
        return json.load(f)

# A function that generates SV code based on the Jinja2 template
def generate_sv_code(config, template_path, output_path):
    # Ensure the template exists before attempting to load it
    print("Looking for template:", template_path)
    env = Environment(loader=FileSystemLoader('templates\sv'))  # Assumes templates folder is in the current directory

    try:
        template = env.get_template(template_path)
    except Exception as e:
        print(f"Error loading template: {e}")
        return

    # Generating the code from the template based on the settings
    rendered_code = template.render(config)

    # Ensure the output folder exists before saving files
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # Saving the generated code to an output file
    with open(output_path, 'w') as f:
        f.write(rendered_code)
    print(f"SV code generated and saved to {output_path}")


# Folder containing the JSON files
template_folder = 'templates/sv'  # Folder where templates are stored
config_file = 'config.json'  # Path to your single JSON config file
output_folder = 'output'  # Folder where you want to save generated SV files

# Reading and running the script
if __name__ == "__main__":
    # Load the single configuration file
    config = load_config(config_file)

    # List all template files in the 'templates' folder
    template_files = [f for f in os.listdir(template_folder) if
                      f.endswith('.sv') and os.path.isfile(os.path.join(template_folder, f))]

    # Ensure output folder exists before saving files
    os.makedirs(output_folder, exist_ok=True)

    # Generate SV code for each template
    for template_file in template_files:
        # Create an output filename based on the template filename (without the extension)
        output_file = os.path.join(output_folder, os.path.splitext(template_file)[0] + '.sv')

        # Generate the SV code using the current template
        generate_sv_code(config, template_file, output_file)

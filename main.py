import json
from jinja2 import Environment, FileSystemLoader


# Read JSON File
def load_config(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)

# A function that generates SV code based on the Jinja2 template
def generate_sv_code(config, template_path, output_path):
    # Loads the template from the file system
    env = Environment(loader=FileSystemLoader('templates'))
    template = env.get_template(template_path)

    # Generating the code from the template based on the settings
    rendered_code = template.render(config)

    # Saving the generated code to an output file
    with open(output_path, 'w') as f:
        f.write(rendered_code)
    print(f"SV code generated and saved to {output_path}")


# Path to the configuration file
config_file = 'config.json'
# Template name
template_file = 'sv_temp.sv'
# Output file Name
output_file = 'output.sv'

# Reading and running the script
if __name__ == "__main__":
    config = load_config(config_file)
    generate_sv_code(config, template_file, output_file)

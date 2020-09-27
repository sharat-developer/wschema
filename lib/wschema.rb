require 'json'
# class Wschema
class Wschema
  def self.labelize(options)
    options
      .tr('_'.freeze, ' '.freeze)
      .strip
      .gsub(/([a-z\d]*)/i) { |s| s.downcase }
      .gsub(/\A\w/) { |s|  s.upcase }
      .gsub(/ id\z/, ' ID'.freeze)
  end

  def self.run_format_schema(schema)
    schema&.each_with_object([]) do |field, array|
      field_name = field['name']
      if (props = field['properties'])
        field['properties'] = run_format_schema(props)
      end

      # removing type for type=string
      if field['type'] == 'string' || field['type'] == :string
        field.delete('type')
      end

      # removing label for field_name.labelize == field[:label]
      if field['label'] &&
         (field['label'] == 'id' || labelize(field_name) == field['label'])
        field.delete('label')
      end

      case field_name
      when 'os'
        field['label'] = 'OS'
      when 'guid'
        field['label'] = 'GUID'
      when 'uuid'
        field['label'] = 'UUID'
      when 'uri'
        field['label'] = 'URI'
      end

      # removing control_type for control_type=text
      if field['control_type'] == 'text' || field['control_type'] == :text
        field.delete('control_type')
      end

      # changing control_type for type=boolean || integer
      if field['type'] == 'boolean' || field['type'] == :boolean
        field['control_type'] = 'checkbox'
      elsif field['type'] == 'integer' || field['type'] == :integer
        field['control_type'] = 'integer'
      end

      field_info = [field['name'].downcase,
                    field['label']&.downcase,
                    field['hint']&.downcase].compact

      if field_info.include?('email')
        field['control_type'] = 'email'
      elsif field_info.include?('phone')
        field['control_type'] = 'phone'
      elsif field_info.include?('uri')
        field['control_type'] = 'url'
      elsif field_info.include?('url')
        field['control_type'] = 'url'
      end

      array << {
        name: field['name'],
        label: field['label'],
        hint: field['hint'],
        default: field['default'],
        sticky: field['sticky'],
        optional: field['optional'],
        extends_schema: field['extends_schema'],
        schema_neutral: field['schema_neutral'],
        add_field_label: field['add_field_label'],
        sample_data_type: field['sample_data_type'],
        custom_properties: field['custom_properties'],
        control_type: field['control_type'],
        empty_list_title: field['empty_list_title'],
        empty_list_text: field['empty_list_text'],
        item_label: field['item_label'],
        pick_list: field['pick_list'],
        toggle_hint: field['toggle_hint'],
        # TODO: handle toggle_fields like properties
        toggle_field: field['toggle_field'],
        render_input: field['render_input'],
        parse_output: field['parse_output'],
        type: field['type'],
        of: field['of'],
        properties: field['properties']
      }.compact
    end
  end

  def self.format_schema(workato_schema)
    {
      formatted_schema: run_format_schema(JSON.parse(workato_schema))
        .to_json
    }
  end
end

# p Wschema.format_schema('[ {
# "control_type": "text",
# "label": "Name",
# "type": "string",
# "name": "name"
# }]')

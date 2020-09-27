require 'test/unit'
require 'wschema'

class WschemaTest < Test::Unit::TestCase
  def test_format_schema
    assert_equal %q({:formatted_schema=>"[{\"name\":\"name\"}]"}).strip, Wschema.format_schema(%q([ {
"control_type": "text",
"label": "Name",
"type": "string",
"name": "name"
}])).to_s.strip
  end
end

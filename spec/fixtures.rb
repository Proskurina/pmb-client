module PMB
  module Fixtures

  	def label_templates_json
  	  from_file "label_templates"
  	end  	

  	def label_templates_struct
  	  JSON.parse label_templates_json
  	end

  	def label_template_json
  	  from_file "label_template"
  	end

  	def label_template_struct
  	  JSON.parse label_template_json
  	end

  	def label_types_json
  	  from_file "label_types"
  	end

  	def label_types_struct
  	  JSON.parse label_types_json
  	end

  	def label_type_json
  	  from_file "label_type"
  	end

  	def label_type_struct
  	  JSON.parse label_type_json
  	end

  	def printers_json
  	  from_file "printers"
  	end

  	def printers_struct
  	  JSON.parse printers_json
  	end

  	def printer_json
  	  from_file "printer"
  	end

  	def printer_struct
  	  JSON.parse printer_json
  	end

    def label_template_creation_json
      from_file "label_template_creation"
    end

    def label_template_creation_struct
      JSON.parse label_template_creation_json
    end

  	private

  	def from_file(file_name)
  	  File.read("./spec/fixtures/#{file_name}.json")
  	end

  end
end
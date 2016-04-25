FactoryGirl.define do 
  
  factory :bitmap, class: OpenStruct do
	  x_origin "0030"
    y_origin "0035"
	  horizontal_magnification "2"
    vertical_magnification "4"
    font "A" 
    space_adjustment "12"
    rotational_angles "14"
    sequence(:field_name) {|n| "bitmap_#{n}" }
  end

  factory :barcode, class: OpenStruct do
  	x_origin "0030"
    y_origin "0035"
	  barcode_type "7"
    one_module_width "09"
    height "0170"
    rotational_angle "1"
    one_cell_width "03"
    type_of_check_digit "2"
    bar_height "0001"
    no_of_columns "01"
    sequence(:field_name) {|n| "barcode_#{n}" }
  end

  factory :label_with_bitmaps, class: OpenStruct do
  	sequence(:name) {|n| "label #{n}"} 
  	bitmap
  	barcode
  end

  factory :label_template, class: OpenStruct do
  	type "label_templates"
  	attributes ({
  		name: "LabWhere",
  		label_type_id: "1",
  		labels_attributes: (
  		  [ FactoryGirl.build(:label_with_bitmaps, name: "header"),
	        FactoryGirl.build_list(:label_with_bitmaps, 5),
	        FactoryGirl.build(:label_with_bitmaps, name: "footer")
	      ].flatten 
  		)
  	})

  end
	
end
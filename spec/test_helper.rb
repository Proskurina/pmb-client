$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pmb'
require 'rspec'

PMB.api_base = 'http://pmb.dev/api/v1'

def printers_json
  "{\"data\":[{\"id\":\"1\",\"type\":\"printers\",\"attributes\":{\"name\":\"ippbc\",\"protocol\":\"LPD\"}},{\"id\":\"2\",\"type\":\"printers\",\"attributes\":{\"name\":\"d304bc\",\"protocol\":\"LPD\"}},{\"id\":\"3\",\"type\":\"printers\",\"attributes\":{\"name\":\"e367bc\",\"protocol\":\"LPD\"}},{\"id\":\"4\",\"type\":\"printers\",\"attributes\":{\"name\":\"e364bc\",\"protocol\":\"LPD\"}},{\"id\":\"5\",\"type\":\"printers\",\"attributes\":{\"name\":\"e365bc2\",\"protocol\":\"LPD\"}}]}"
end

def printers_struct
  JSON.parse(printers_json)
end

def printer_json(args = {})
  id = args.fetch(:id, 1)
  name = args.fetch(:name, 'ippbc')
  protocol = args.fetch(:protocol, 'LPD')
  "{\"data\":{\"id\":\"#{id}\",\"type\":\"printers\",\"attributes\":{\"name\":\"#{name}\",\"protocol\":\"#{protocol}\"}}}"
end

def printer_struct
  JSON.parse(printer_json)
end

def label_type_json(args = {})
  JSON.generate({
    data: {
      id: "1",
      type: "label_types",
      attributes: {
        feed_value: args.fetch(:feed_value, "008"),
        fine_adjustment: args.fetch(:fine_adjustment, "04"),
        pitch_length: args.fetch(:pitch_length, "0110"),
        print_width: args.fetch(:print_width, "0920"),
        print_length: args.fetch(:print_length, "0080"),
        name: args.fetch(:name, "Plate")
        }
      }
  })
end

def label_type_struct
  JSON.parse(label_type_json)
end

def label_types_json
  JSON.generate({
    data: [{
      id: "1",
      type: "label_types",
      attributes: {
        feed_value: "008",
        fine_adjustment: "04",
        pitch_length: "0110",
        print_width: "0920",
        print_length: "0080",
        name: "Plate"
      }
    }, {
      id: "2",
      type: "label_types",
      attributes: {
        feed_value: "002",
        fine_adjustment: "10",
        pitch_length: "0280",
        print_width: "0330",
        print_length: "0200",
        name: "CGAP - Fat"
      }
    },
    {
      id: "3",
      type: "label_types",
      attributes: {
        feed_value: "002",
        fine_adjustment: "10",
        pitch_length: "0110",
        print_width: "0850",
        print_length: "0070",
        name: "CGAP - Thin"
      }
    }
  ]}
  )
end

def label_types_struct
  JSON.parse(label_types_json)
end

def print_job_json
  JSON.generate(print_job_params)
end

def print_job_struct
  {
    "data": {
      "id": "",
      "type": "print_jobs",
      "attributes": {
        "printer_name": "d304bc",
        "label_template_id": 1,
        "labels": {
          "header": {
            "header_text_1": "header_text_1",
            "header_text_2": "header_text_2"
          },
          "footer": {
            "footer_text_1": "footer_text_1",
            "footer_text_2": "footer_text_2"
          },
          "body": [
            {
              "location": {
                "location": "location",
                "parent_location": "parent_location",
                "barcode": "barcode"
              }
            },
            {
              "location": {
                "location": "location",
                "parent_location": "parent_location",
                "barcode": "barcode"
              }
            }
          ]
        }
      }
    }
  }
end

# RestClient related helpers
def request_raises(exception)
  allow(RestClient::Request).to receive(:execute).and_raise(exception)
end

def request_returns(response_params)
  allow(RestClient::Request).to receive(:execute)
    .and_return(instance_double(RestClient::Response, response_params))
end

def rest_client_exception(code)
  RestClient::Exceptions::EXCEPTIONS_MAP.fetch(code).new(nil, code)
end
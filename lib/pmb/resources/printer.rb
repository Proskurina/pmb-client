module PMB
  class Printer < PMB::Resource

    self.endpoint = 'printers'

    attr_accessor :id, :type, :attributes

    # Valid protocols
    LPD = 'LPD'
    IPP = 'IPP'
    TOF = 'TOF'

    private

    def self.to_json(args)
      name = args.fetch(:name, nil)
      # Since the API defaults to creating LPD, it makes sense that this should too
      protocol = args.fetch(:protocol, PMB::Printer::LPD)
      return PrinterCreation.new(name, protocol).to_json
    end

    PrinterCreation = Struct.new(:name, :protocol) do

      def to_json
        JSON.generate(
          data: {
            type: 'printers', # I'm going to say for now this is always "printers"...
            attributes: {
              name: name,
              protocol: protocol
            }
          }
        )
      end

    end

  end
end
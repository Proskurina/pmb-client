module PMB
  class Printers < PMB::Collection

    self.model = PMB::Printer
    self.endpoint = 'printers'

  end
end
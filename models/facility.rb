class Facility
  # Override Facility.new for the demo so we don't need to instantiate one from the API
  def self.new *_
    Facility.sample_facility
  end

  # Define a sample facility record so we don't need to muck with API calls for demo
  def self.sample_facility
    {
      name: "Red Nova Stor",
      phone: "(555) 123-4567",
      time_zone: "Eastern Time (US & Canada)",
      company_id: 213,
      public_url: "http://www.rednovalabs.com",
      access_hours_same_as_office_hours: false,
      email: "abrown@rednovalabs.com",
      fax: "(555) 789-1234",
      direct_phone: "(555) 411-1111",
      open_hour: '7AM',
      close_hour: '5PM',
      open_days: 'M-F'
    }
  end
end

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
      address: "4831 Rainbow Blvd.",
      time_zone: "Eastern Time (US & Canada)",
      company_id: 213,
      public_url: "http://www.rednovalabs.com",
      access_hours_same_as_office_hours: false,
      email: "abrown@rednovalabs.com",
      fax: "(555) 789-1234",
      direct_phone: "(555) 411-1111",
      open_hour: '7am',
      close_hour: '5pm',
      open_days: 'Monday through Friday',
      unit_sizes_available: '5x5, 5x10, 10x10, and 10x20',
    }
  end
end

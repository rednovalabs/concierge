class Facility
  # Override Facility.new for the demo so we don't need to instantiate one from the API
  def self.new *_
    Facility.sample_facility
  end

  # Define a sample facility record so we don't need to muck with API calls for demo
  def self.sample_facility
    {
      id: 1868,
      name: "Red Nova Stor",
      phone: "(555) 123-4567",
      time_zone: "Eastern Time (US & Canada)",
      company_id: 213,
      created_at: "2016-02-01T05: 22: 24.692-10: 00",
      updated_at: "2016-02-01T05: 31: 07.320-10: 00",
      deleted: false,
      deleted_on: null,
      deleted_by_id: null,
      last_exported_on: null,
      public_url: "http://www.rednovalabs.com",
      access_hours_same_as_office_hours: false,
      next_lease_number: 101,
      email: "abrown@rednovalabs.com",
      fax: "(555) 789-1234",
      custom_portal_url: "",
      brand_name: "",
      landmarks: null,
      max_truck_length: null,
      direct_phone: "(555) 411-1111",
      notice: null
    }
  end
end

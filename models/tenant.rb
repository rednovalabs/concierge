class Tenant
  # Override Tenant.new for the demo so we don't need to instantiate one from the API
  def self.new *_
    Tenant.sample_tenant
  end

  # Define a sample tenant record so we don't need to muck with API calls for demo
  def self.sample_tenant
    {
      id: 1234,
      first_name: "Dan",
      last_name: "Miller",
      email: "abrown@rednovalabs.com",
      facility_id: 1582,
      middle_initial: "F",
      dob: nil, #todo wish tenants happy birthday?
      username: "dmiller",
      company_id: 1,
      unit_name: 'B52',
      gate_code: '7201',
      balance_due: '$79.24',
      balance_due_on: '3/1/16'
      move_in_date: 'April 9, 2016'
    }
  end
end

class Tenant
  def self.new
    Tenant.sample_tenant
  end

  # Define a sample tenant record so we don't need to muck with API calls for demo
  def self.sample_tenant
    {
      id: 1234,
      first_name: "Dan",
      last_name: "Miller",
      email: "abrown@rednovalabs.com",
      tax_exempt: false,
      tax_exempt_number: nil,
      drivers_license_number: '123456789',
      drivers_license_state: 'KS',
      facility_id: 1582,
      created_at: "2016-02-01T06: 20: 53.413-10: 00",
      updated_at: "2016-02-01T06: 21: 20.928-10: 00",
      payment_provider_token: nil,
      payment_provider_checksum: nil,
      is_business: false,
      business_name: "",
      last_ua: nil,
      middle_initial: "F",
      dob: nil, #todo wish tenants happy birthday?
      title: nil,
      uuid: "c82fbfba-fb35-4fea-ab3f-17852dc261c4",
      gate_vendor_data: {},
      delinquent: false,
      username: "dmiller",
      password_expired: false,
      payment_provider_token_enc: nil,
      vehicle_license_plate_number: nil,
      vehicle_description: nil,
      primary_contact_id: nil,
      primary_phone_number_id: nil,
      vehicle_license_state: nil,
      account_number: 1234567,
      company_id: 1,
      tenant_account_kind_id: nil,
      confirmation_index: 1,
      is_military: nil,
      invalid_email: false,
      gate_24_hour_access: false
    }
  end
end

require 'summarize_codes/version'
require 'health-data-standards'

module SummarizeCodes

  HEADER_ROW = 0
  CODE_SYSTEM_COLUMN = 3
  CODE_COLUMN = 4
  COUNT_COLUMN = 5

  CODE_SYSTEM_ALIASES = {
    'ICD9CM' => 'ICD-9-CM',
    'ICD9PCS' => 'ICD-9-PCS',
    'RXNORM' => 'RxNorm',
    'SNOMEDCT' => 'SNOMED-CT'
  }
  
  LOINC_TO_SNOMED = {
    "8462-4" => "271650006",
    "8480-6" => "271649006",
    "8302-2" => "248327008",
    "3141-9" => "107647005",
    "8867-4" => "366199006",
    "9279-1" => "366147009",
    "8310-5" => "309646008"
  }
  
  def self.oid_for_code_system_name(name)
    name = CODE_SYSTEM_ALIASES[name] if CODE_SYSTEM_ALIASES[name]
    HealthDataStandards::Util::CodeSystemHelper.oid_for_code_system(name)
  end
      
  LOINC_OID = SummarizeCodes.oid_for_code_system_name('LOINC')
  SNOMED_OID = SummarizeCodes.oid_for_code_system_name('SNOMED-CT')

  def self.validate_csv(rows)
    header = rows[HEADER_ROW]
    raise 'Did not find code system in column d' unless header[CODE_SYSTEM_COLUMN] == 'Code System'
    raise 'Did not find code in column e' unless header[CODE_COLUMN] == 'Code'
    rows
  end
  
  def self.summarize_csv(rows, summary)
    rows[1..-1].each do |row|
      code_system_oid = SummarizeCodes.oid_for_code_system_name(row[CODE_SYSTEM_COLUMN])
      summary[code_system_oid] ||= {}
      code = row[CODE_COLUMN]
      count = row[COUNT_COLUMN].to_i
      if count > 0
        summary[code_system_oid][code] = count
        # Map LOINC vitals to SNOMED
        if code_system_oid == LOINC_OID && LOINC_TO_SNOMED[code]
          summary[SNOMED_OID] ||= {}
          summary[SNOMED_OID][LOINC_TO_SNOMED[code]] = count
        end
      end
    end
    summary
  end

end

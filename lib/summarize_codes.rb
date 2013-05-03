require 'summarize_codes/version'
require 'health-data-standards'

module SummarizeCodes

  HEADER_ROW = 0
  CODE_SYSTEM_COLUMN = 3
  CODE_COLUMN = 4
  COUNT_COLUMN = 5

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
      end
    end
    summary
  end

  CODE_SYSTEM_ALIASES = {
    'ICD9CM' => 'ICD-9-CM',
    'ICD9PCS' => 'ICD-9-PCS'
  }
  
  def self.oid_for_code_system_name(name)
    name = CODE_SYSTEM_ALIASES[name] if CODE_SYSTEM_ALIASES[name]
    HealthDataStandards::Util::CodeSystemHelper.oid_for_code_system(name)
  end
      
end

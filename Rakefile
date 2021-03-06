require 'bundler/gem_tasks'
require_relative 'lib/summarize_codes'

namespace :codes do
  desc 'Summarize code counts from CSV frequency counts'
  task :summarize, [:csv_dir] do |t, args|
    puts "Loading CSV from #{args.csv_dir}"
    
    summary = {}
    Dir.glob(File.join(args.csv_dir, '**', '*.csv')).each do |f|
    	csv = CSV.read(f)
    	SummarizeCodes.validate_csv(csv)
    	SummarizeCodes.summarize_csv(csv,summary)
    end
    SummarizeCodes.add_stats(summary)
    
    puts("Writing results to ./tmp")
    out_dir = File.join(".", "tmp")
    ts = Time.now.strftime("%Y%m%d-%H%M%S")
    FileUtils.mkdir_p(out_dir)
    
    File.open(File.join(out_dir, "summary%s.json" % ts), 'w') do |f|
      f.write(JSON.pretty_generate(summary))
    end
    
    summary.each do |oid, codes|
    	name = HealthDataStandards::Util::CodeSystemHelper.code_system_for(oid)
    	stats = codes['summary']
    	puts "#{name}: #{stats['found']} #{stats['not_found']} #{stats['found_once']} #{stats['found_five_or_less']}"
    end
  end
end
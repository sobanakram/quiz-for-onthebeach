require './lib/job'

class JobSorter

  def initialize(string)
    @job_structure = string
  end

  def sort
    if @job_structure == ""
      ""
    else
      jobs_list = []
      lines = @job_structure.split(", ")
      lines.each do |line|
        str_list = line.split('=>')
        if str_list.size == 1
          jobs_list << Job.new(str_list.first) if jobs_list.select { |job| job.name == str_list.first }.first.nil?
        else
          return 'jobs can not depend on itself' if str_list.first == str_list.last
          first_job = jobs_list.select { |job| job.name == str_list.first }.first || Job.new(str_list.first)
          second_job = jobs_list.select { |job| job.name == str_list.last }.first || Job.new(str_list.last)

          first_job.depends_on = second_job if first_job.depends_on.nil?
          second_job.dependent << first_job if second_job.dependent.select { |job| job == first_job }.first.nil?
          jobs_list << first_job unless jobs_list.index(first_job)
          jobs_list << second_job unless jobs_list.index(second_job)
        end
      end

      jobs_with_depends = jobs_list.select { |job| job.depends_on.nil? }
      result = jobs_with_depends.map(&:dependents_names).join('')
      if result.split(' ').size < jobs_list.size
        return 'jobs can not have circular dependencies'
      end
      result
    end
  end
end


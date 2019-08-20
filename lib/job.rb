class Job
  attr_accessor :name, :depends_on, :dependent

  def initialize(name, depends_on = nil)
    @name = name
    @depends_on = depends_on
    @dependent = []
  end

    def dependents_names
    "#{name} #{dependent.map(&:dependents_names).join(' ')}"
  end
end
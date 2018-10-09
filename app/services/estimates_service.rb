class EstimatesService
  def initialize
    @estimates_by_location = {}
  end

  def add(source, target, distance)
    estimate = Estimate.new(target: target,
                            previous: source,
                            distance: distance)
    @estimates_by_location[source] ||= []
    @estimates_by_location[source].push estimate
  end

  def by_location(source)
    @estimates_by_location[source]
  end

  def find(source, target)
    @estimates_by_location[source].select { |e| e.target.eql? target }
  end

  def add_new(source, target, previous, distance)
    estimate = Estimate.new(target: target,
                            previous: previous,
                            distance: distance)
    @estimates_by_location[source].push estimate
  end

  def estimates_opened?(source)
    @estimates_by_location[source].select(&:opened?).present?
  end
end

class Estimate
  attr_reader :target
  attr_accessor :previous, :distance

  def initialize(**params)
    @target = params[:target]
    @previous = params[:previous]
    @distance = params[:distance]
    @status = :opened
  end

  def opened?
    @status == :opened
  end

  def close!
    @status = :closed
  end
end

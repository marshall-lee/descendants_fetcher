module DescendantsFetcher
  def descendants
    ObjectSpace.each_object(singleton_class).to_a
  end

  if RUBY_ENGINE == 'jruby'
    require 'jruby'

    def descendants
      if JRuby.objectspace
        ObjectSpace.each_object(singleton_class).to_a
      else
        ObjectSpace.each_object(Class).select { |klass| klass <= self }
      end
    end
  end

  def subclasses
    descendants.select! { |klass| klass.superclass == self }
  end
end

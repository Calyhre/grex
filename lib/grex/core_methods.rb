module CoreMethods
  def stringify(things)
    case things
    when Hash
      { :$substr => [ things, 0, -1 ] }
    when Symbol
      { :$substr => [ "$#{sym}", 0, -1 ] }
    end
  end

  def let(vars, _in)
    { :$let => { vars: vars, in: _in } }
  end

  def cond(h = { :if => nil , :then => nil, :else => nil })
    { :$cond => [ h[:if], h[:then], h[:else] ] }
  end

  def project(h)
    { :$project => h }
  end

  def unwind(sym)
    { :$unwind => sym }
  end

  def match(h)
    { :$match => h }
  end

  def limit(n)
    { :$limit => n }
  end

  def skip(n)
    { :$skip => n }
  end

  def sort(h)
    { :$sort => h }
  end

  def group(h)
    { :$group => h }
  end

  def redact(h)
    { :$redact => h }
  end

  def concat(*args)
    { :$concat => args }
  end

  def out(collection_name)
    { :$out => collection_name }
  end

  def aggregate(*args)
    c = self.respond_to?(:collection) ? collection : self.class.collection
    Config.connection[c].aggregate(args)
  end

  def aggregate_for(collection, *args)
    Config.connection[collection].aggregate(args)
  end

  alias :find :match
end
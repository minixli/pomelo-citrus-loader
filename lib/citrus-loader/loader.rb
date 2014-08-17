# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 17 July 2014

module CitrusLoader

  module ::Citrus end

  # AppRemote
  ::Citrus::AppRemote = Class.new {
    def initialize context
      @app = context
    end
  }
  # AppHandler
  ::Citrus::AppHandler = Class.new {
    def initialize context
      @app = context
    end
  }

  # HandlerFilter
  ::Citrus::HandlerFilter = Class.new
  # RpcFilter
  ::Citrus::RpcFilter = Class.new

  @app_handler_loaded = {}
  @app_remote_loaded = {}

  @handler_filters_loaded = {}
  @rpc_filters_loaded = {}

  class << self
    attr_reader :app_handler_loaded, :app_remote_loaded
    attr_reader :handler_filters_loaded, :rpc_filters_loaded
  end

  # Load app handler
  #
  # @param [String] path
  def load_app_handler path
    if !File.directory? path
      raise ArgumentError, 'expected a directory'
    end

    result = []
    Dir.glob(File.join(path, '') + '*.rb').each { |filepath|
      if CitrusLoader.app_handler_loaded[filepath]
        result << CitrusLoader.app_handler_loaded[filepath]
      else
        ::Citrus::AppHandler.define_singleton_method(:inherited) { |subclass|
          CitrusLoader.app_handler_loaded[filepath] = subclass
          result << subclass
        }
        require filepath
      end
    }
    result
  end

  # Load app remote
  #
  # @param [String] path
  def load_app_remote path
    if !File.directory? path
      raise ArgumentError, 'expected a directory'
    end

    subclasses = []
    Dir.glob(File.join(path, '') + '*.rb').each { |filepath|
      if subclass = CitrusLoader.app_remote_loaded[filepath]
        subclasses << subclass
      else
        ::Citrus::AppRemote.define_singleton_method(:inherited) { |subclass|
          CitrusLoader.app_remote_loaded[filepath] = subclass
          subclasses << subclass
        }
        require filepath
      end
    }

    result = {}
    subclasses.each { |subclass|
      service = get_service_name subclass
      result[service] = subclass
    }
    result
  end

  # Load handler filters
  #
  # @param [String] path
  def load_handler_filters path
    if !File.directory? path
      raise ArgumentError, 'expected a directory'
    end

    result = []
    Dir.glob(File.join(path, '') + '*.rb').each { |filepath|
      if CitrusLoader.handler_filters_loaded[filepath]
        result << CitrusLoader.handler_filters_loaded[filepath]
      else
        ::Citrus::HandlerFilter.define_singleton_method(:inherited) { |subclass|
          CitrusLoader.handler_filters_loaded[filepath] = subclass
          result << subclass
        }
        require filepath
      end
    }
    result
  end

  # Load rpc filters
  #
  # @param [String] path
  def load_rpc_filters path
    if !File.directory? path
      raise ArgumentError, 'expected a directory'
    end

    result = []
    Dir.glob(File.join(path, '') + '*.rb').each { |filepath|
      if CitrusLoader.rpc_filters_loaded[filepath]
        result << CitrusLoader.rpc_filters_loaded[filepath]
      else
        ::Citrus::RpcFilter.define_singleton_method(:inherited) { |subclass|
          CitrusLoader.rpc_filters_loaded[filepath] = subclass
          result << subclass
        }
        require filepath
      end
    }
    result
  end

  # Get service name
  #
  # @param [Class] subclass
  def get_service_name subclass
    service = subclass.name
    service[0] = service[0].downcase
    service
  end
end

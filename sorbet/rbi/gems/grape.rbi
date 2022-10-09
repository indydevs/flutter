# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/grape/all/grape.rbi
#
# grape-1.6.2

module Grape
  def self.config; end
  def self.configure; end
  extend ActiveSupport::Autoload
  extend Grape::Config
end
module Grape::Middleware
  extend ActiveSupport::Autoload
end
module Grape::Middleware::Versioner
  def self.using(strategy); end
  def using(strategy); end
  extend ActiveSupport::Autoload
end
module Grape::Util
  extend ActiveSupport::Autoload
end
module Grape::Util::Registrable
  def default_elements; end
  def register(format, element); end
end
module Grape::ErrorFormatter
  def self.builtin_formatters; end
  def self.formatter_for(api_format, **options); end
  def self.formatters(**options); end
  extend ActiveSupport::Autoload
  extend Grape::Util::Registrable
end
module Grape::Formatter
  def self.builtin_formatters; end
  def self.formatter_for(api_format, **options); end
  def self.formatters(**options); end
  extend ActiveSupport::Autoload
  extend Grape::Util::Registrable
end
module Grape::Parser
  def self.builtin_parsers; end
  def self.parser_for(api_format, **options); end
  def self.parsers(**options); end
  extend ActiveSupport::Autoload
  extend Grape::Util::Registrable
end
class Grape::Util::Cache
  def cache; end
  def self.[](*args, &block); end
  def self.allocate; end
  def self.cache(*args, &block); end
  def self.new(*arg0); end
  extend Singleton::SingletonClassMethods
  include Singleton
end
class Grape::Router
  def append(route); end
  def associate_routes(pattern, **options); end
  def call(env); end
  def call_with_allow_headers(env, route); end
  def cascade?(response); end
  def compile!; end
  def compiled; end
  def default_response; end
  def extract_input_and_method(env); end
  def greedy_match?(input); end
  def identity(env); end
  def initialize; end
  def make_routing_args(default_args, route, input); end
  def map; end
  def match?(input, method); end
  def prepare_env_from_route(env, route); end
  def process_route(route, env); end
  def recognize_path(input); end
  def rotation(env, exact_route = nil); end
  def self.normalize_path(path); end
  def self.supported_methods; end
  def string_for(input); end
  def transaction(env); end
  def with_optimization; end
end
class Grape::Router::Pattern
  def ===(*args, &block); end
  def build_path(pattern, anchor: nil, suffix: nil, **_options); end
  def extract_capture(requirements: nil, **options); end
  def initialize(pattern, **options); end
  def match?(*args, &block); end
  def named_captures(*args, &block); end
  def origin; end
  def params(*args, &block); end
  def path; end
  def pattern; end
  def pattern_options(options); end
  def to_regexp; end
  extend Forwardable
end
class Grape::Router::Pattern::PatternCache < Grape::Util::Cache
  def initialize; end
end
class Grape::Router::AttributeTranslator
  def attributes; end
  def description; end
  def details; end
  def entity; end
  def format; end
  def headers; end
  def http_codes; end
  def index; end
  def initialize(**attributes); end
  def method_missing(method_name, *args); end
  def namespace; end
  def pattern; end
  def prefix; end
  def request_method; end
  def requirements; end
  def respond_to_missing?(method_name, _include_private = nil); end
  def setter?(method_name); end
  def settings; end
  def to_h; end
  def version; end
end
class Grape::Router::Route
  def app; end
  def app=(arg0); end
  def apply(app); end
  def attributes; end
  def description(*args, &block); end
  def details(*args, &block); end
  def entity(*args, &block); end
  def exec(env); end
  def format(*args, &block); end
  def headers(*args, &block); end
  def http_codes(*args, &block); end
  def index; end
  def index=(arg0); end
  def initialize(method, pattern, **options); end
  def match?(input); end
  def method_missing(method_id, *arguments); end
  def namespace(*args, &block); end
  def options; end
  def options=(arg0); end
  def origin(*args, &block); end
  def params(input = nil); end
  def path(*args, &block); end
  def pattern; end
  def pattern=(arg0); end
  def prefix(*args, &block); end
  def request_method(*args, &block); end
  def requirements(*args, &block); end
  def respond_to_missing?(method_id, _); end
  def route_method; end
  def route_path; end
  def settings(*args, &block); end
  def translator; end
  def translator=(arg0); end
  def version(*args, &block); end
  def warn_route_methods(name, location, expected = nil); end
  extend Forwardable
end
module Grape::Middleware::Auth
  extend ActiveSupport::Autoload
end
module Grape::Middleware::Auth::DSL
  extend ActiveSupport::Concern
end
module Grape::Middleware::Auth::DSL::ClassMethods
  def auth(type = nil, options = nil, &block); end
  def http_basic(options = nil, &block); end
  def http_digest(options = nil, &block); end
end
module Grape::DSL
  extend ActiveSupport::Autoload
end
module Grape::DSL::Settings
  def api_class_setting(key, value = nil); end
  def build_top_level_setting; end
  def get_or_set(type, key, value); end
  def global_setting(key, value = nil); end
  def inheritable_setting; end
  def inheritable_setting=(arg0); end
  def namespace_end; end
  def namespace_inheritable(key, value = nil); end
  def namespace_inheritable_to_nil(key); end
  def namespace_reverse_stackable(key, value = nil); end
  def namespace_reverse_stackable_with_hash(key); end
  def namespace_setting(key, value = nil); end
  def namespace_stackable(key, value = nil); end
  def namespace_stackable_with_hash(key); end
  def namespace_start; end
  def route_end; end
  def route_setting(key, value = nil); end
  def top_level_setting; end
  def top_level_setting=(arg0); end
  def unset(type, key); end
  def unset_api_class_setting(key); end
  def unset_global_setting(key); end
  def unset_namespace_inheritable(key); end
  def unset_namespace_setting(key); end
  def unset_namespace_stackable(key); end
  def unset_route_setting(key); end
  def within_namespace(&block); end
  extend ActiveSupport::Concern
end
module Grape::DSL::Logger
  def logger(logger = nil); end
  def logger=(arg0); end
  include Grape::DSL::Settings
end
module Grape::DSL::Desc
  def desc(description, options = nil, &config_block); end
  def desc_container(endpoint_configuration); end
  def description_field(field, value = nil); end
  def unset_description_field(field); end
  include Grape::DSL::Settings
end
module Grape::DSL::Configuration
  extend ActiveSupport::Concern
end
module Grape::DSL::Configuration::ClassMethods
  include Grape::DSL::Desc
  include Grape::DSL::Logger
  include Grape::DSL::Settings
end
module Grape::DSL::Validations
  extend ActiveSupport::Concern
  include Grape::DSL::Configuration
end
module Grape::DSL::Validations::ClassMethods
  def document_attribute(names, opts); end
  def params(&block); end
  def reset_validations!; end
end
module Grape::DSL::Callbacks
  extend ActiveSupport::Concern
  include Grape::DSL::Configuration
end
module Grape::DSL::Callbacks::ClassMethods
  def after(&block); end
  def after_validation(&block); end
  def before(&block); end
  def before_validation(&block); end
  def finally(&block); end
end
module Grape::DSL::Helpers
  extend ActiveSupport::Concern
  include Grape::DSL::Configuration
end
module Grape::DSL::Helpers::ClassMethods
  def define_boolean_in_mod(mod); end
  def helpers(*new_modules, &block); end
  def include_all_in_scope; end
  def include_block(block); end
  def include_new_modules(modules); end
  def inject_api_helpers_to_mod(mod, &block); end
  def make_inclusion(mod, &block); end
end
module Grape::DSL::Helpers::BaseHelper
  def api; end
  def api=(arg0); end
  def api_changed(new_api); end
  def params(name, &block); end
  def process_named_params; end
end
module Grape::DSL::Middleware
  extend ActiveSupport::Concern
  include Grape::DSL::Configuration
end
module Grape::DSL::Middleware::ClassMethods
  def insert(*args, &block); end
  def insert_after(*args, &block); end
  def insert_before(*args, &block); end
  def middleware; end
  def use(middleware_class, *args, &block); end
end
module Grape::DSL::RequestResponse
  extend ActiveSupport::Concern
  include Grape::DSL::Configuration
end
module Grape::DSL::RequestResponse::ClassMethods
  def content_type(key, val); end
  def content_types; end
  def default_error_formatter(new_formatter_name = nil); end
  def default_error_status(new_status = nil); end
  def default_format(new_format = nil); end
  def error_formatter(format, options); end
  def extract_with(options); end
  def format(new_format = nil); end
  def formatter(content_type, new_formatter); end
  def parser(content_type, new_parser); end
  def represent(model_class, options); end
  def rescue_from(*args, &block); end
end
class Grape::Util::LazyObject < BasicObject
  def !; end
  def !=(other); end
  def ==(other); end
  def __target_object__; end
  def callable; end
  def initialize(&callable); end
  def method_missing(method_name, *args, &block); end
  def respond_to_missing?(method_name, include_priv = nil); end
end
module Grape::Http
  extend ActiveSupport::Autoload
end
module Grape::Http::Headers
  def self.find_supported_method(route_method); end
end
module Grape::DSL::Routing
  extend ActiveSupport::Concern
  include Grape::DSL::Configuration
end
module Grape::DSL::Routing::ClassMethods
  def delete(*args, &block); end
  def do_not_route_head!; end
  def do_not_route_options!; end
  def endpoints; end
  def get(*args, &block); end
  def group(space = nil, options = nil, &block); end
  def head(*args, &block); end
  def mount(mounts, *opts); end
  def namespace(space = nil, options = nil, &block); end
  def options(*args, &block); end
  def patch(*args, &block); end
  def post(*args, &block); end
  def prefix(prefix = nil); end
  def put(*args, &block); end
  def reset_endpoints!; end
  def reset_routes!; end
  def resource(space = nil, options = nil, &block); end
  def resources(space = nil, options = nil, &block); end
  def route(methods, paths = nil, route_options = nil, &block); end
  def route_param(param, options = nil, &block); end
  def routes; end
  def scope(_name = nil, &block); end
  def segment(space = nil, options = nil, &block); end
  def version(*args, &block); end
  def versions; end
end
module Grape::DSL::API
  extend ActiveSupport::Concern
  include Grape::DSL::Callbacks
  include Grape::DSL::Configuration
  include Grape::DSL::Helpers
  include Grape::DSL::Middleware
  include Grape::DSL::RequestResponse
  include Grape::DSL::Routing
  include Grape::DSL::Validations
  include Grape::Middleware::Auth::DSL
end
class Grape::Util::InheritableSetting
  def api_class; end
  def api_class=(arg0); end
  def global; end
  def inherit_from(parent); end
  def initialize; end
  def namespace; end
  def namespace=(arg0); end
  def namespace_inheritable; end
  def namespace_inheritable=(arg0); end
  def namespace_reverse_stackable; end
  def namespace_reverse_stackable=(arg0); end
  def namespace_stackable; end
  def namespace_stackable=(arg0); end
  def parent; end
  def parent=(arg0); end
  def point_in_time_copies; end
  def point_in_time_copies=(arg0); end
  def point_in_time_copy; end
  def route; end
  def route=(arg0); end
  def route_end; end
  def self.global; end
  def self.reset_global!; end
  def to_hash; end
end
class Grape::Util::BaseInheritable
  def delete(key); end
  def inherited_values; end
  def inherited_values=(arg0); end
  def initialize(inherited_values = nil); end
  def initialize_copy(other); end
  def key?(name); end
  def keys; end
  def new_values; end
  def new_values=(arg0); end
end
class Grape::Util::InheritableValues < Grape::Util::BaseInheritable
  def [](name); end
  def []=(name, value); end
  def merge(new_hash); end
  def to_hash; end
  def values; end
end
class Grape::Util::StackableValues < Grape::Util::BaseInheritable
  def [](name); end
  def []=(name, value); end
  def concat_values(inherited_value, new_value); end
  def to_hash; end
end
class Grape::Util::ReverseStackableValues < Grape::Util::StackableValues
  def concat_values(inherited_value, new_value); end
end
class Grape::API
  def self.add_setup(method, *args, &block); end
  def self.any_lazy?(args); end
  def self.base_instance; end
  def self.base_instance=(arg0); end
  def self.call(*args, &block); end
  def self.compile!; end
  def self.configure; end
  def self.const_missing(*args); end
  def self.evaluate_arguments(configuration, *args); end
  def self.inherited(api); end
  def self.initial_setup(base_instance_parent); end
  def self.instance_for_rack; end
  def self.instances; end
  def self.instances=(arg0); end
  def self.method_missing(method, *args, &block); end
  def self.mount_instance(**opts); end
  def self.mounted_instances; end
  def self.never_mounted?; end
  def self.new(*args, &block); end
  def self.override_all_methods!; end
  def self.replay_setup_on(instance); end
  def self.replay_step_on(instance, setup_step); end
  def self.respond_to?(method, include_private = nil); end
  def self.respond_to_missing?(method, include_private = nil); end
  def self.skip_immediate_run?(instance, args); end
  extend ActiveSupport::Autoload
end
class Grape::API::Instance
  def add_head_not_allowed_methods_and_options_methods; end
  def call(env); end
  def cascade?; end
  def collect_route_config_per_pattern; end
  def generate_not_allowed_method(pattern, allowed_methods: nil, **attributes); end
  def initialize; end
  def router; end
  def self.base; end
  def self.base=(grape_api); end
  def self.base_instance?; end
  def self.call!(env); end
  def self.call(env); end
  def self.cascade(value = nil); end
  def self.change!; end
  def self.compile!; end
  def self.compile; end
  def self.configuration; end
  def self.configuration=(arg0); end
  def self.evaluate_as_instance_with_configuration(block, lazy: nil); end
  def self.given(conditional_option, &block); end
  def self.inherit_settings(other_settings); end
  def self.inherited(subclass); end
  def self.instance; end
  def self.mounted(&block); end
  def self.nest(*blocks, &block); end
  def self.prepare_routes; end
  def self.recognize_path(path); end
  def self.reset!; end
  def self.to_s; end
  def without_root_prefix(&_block); end
  def without_versioning(&_block); end
  extend Grape::DSL::Callbacks::ClassMethods
  extend Grape::DSL::Configuration::ClassMethods
  extend Grape::DSL::Helpers::ClassMethods
  extend Grape::DSL::Middleware::ClassMethods
  extend Grape::DSL::RequestResponse::ClassMethods
  extend Grape::DSL::Routing::ClassMethods
  extend Grape::DSL::Validations::ClassMethods
  extend Grape::Middleware::Auth::DSL::ClassMethods
  include Grape::DSL::API
  include Grape::DSL::Callbacks
  include Grape::DSL::Configuration
  include Grape::DSL::Configuration
  include Grape::DSL::Configuration
  include Grape::DSL::Configuration
  include Grape::DSL::Configuration
  include Grape::DSL::Configuration
  include Grape::DSL::Configuration
  include Grape::DSL::Helpers
  include Grape::DSL::Middleware
  include Grape::DSL::RequestResponse
  include Grape::DSL::Routing
  include Grape::DSL::Validations
  include Grape::Middleware::Auth::DSL
end
class Grape::API::Boolean
  def self.build(val); end
end
module Grape::Extensions
  extend ActiveSupport::Autoload
end
module Grape::Extensions::ActiveSupport
  extend ActiveSupport::Autoload
end
module Grape::Extensions::ActiveSupport::HashWithIndifferentAccess
end
module Grape::Extensions::ActiveSupport::HashWithIndifferentAccess::ParamBuilder
  def build_params; end
  def params_builder; end
  extend ActiveSupport::Concern
end
module Grape::Config
  def self.extended(base); end
end
class Grape::Config::Configuration
  def initialize; end
  def param_builder; end
  def param_builder=(arg0); end
  def reset; end
end
module Grape::ContentTypes
  def self.content_types_for(from_settings); end
  def self.content_types_for_settings(settings); end
  extend Grape::Util::Registrable
end
class Grape::Util::LazyValue
  def access_keys; end
  def evaluate; end
  def evaluate_from(configuration); end
  def initialize(value, access_keys = nil); end
  def lazy?; end
  def reached_by(parent_access_keys, access_key); end
  def to_s; end
end
class Grape::Util::LazyValueEnumerable < Grape::Util::LazyValue
  def [](key); end
  def []=(key, value); end
  def fetch(access_keys); end
end
class Grape::Util::LazyValueArray < Grape::Util::LazyValueEnumerable
  def evaluate; end
  def initialize(array); end
end
class Grape::Util::LazyValueHash < Grape::Util::LazyValueEnumerable
  def evaluate; end
  def initialize(hash); end
end
class Grape::Util::LazyBlock
  def evaluate; end
  def evaluate_from(configuration); end
  def initialize(&new_block); end
  def lazy?; end
  def to_s; end
end
class Grape::Util::EndpointConfiguration < Grape::Util::LazyValueHash
end
module Grape::Validations
  def self.deregister_validator(short_name); end
  def self.register_validator(short_name, klass); end
  def self.validators; end
  def self.validators=(arg0); end
end
class Grape::Validations::AttributesIterator
  def do_each(params_to_process, parent_indicies = nil, &block); end
  def each(&block); end
  def initialize(validator, scope, params); end
  def scope; end
  def skip?(val); end
  def yield_attributes(_resource_params, _attrs); end
  include Enumerable
end
class Grape::Validations::SingleAttributeIterator < Grape::Validations::AttributesIterator
  def empty?(val); end
  def yield_attributes(val, attrs); end
end
class Grape::Validations::MultipleAttributesIterator < Grape::Validations::AttributesIterator
  def yield_attributes(resource_params, _attrs); end
end
module Grape::DSL::Parameters
  def all_or_none_of(*attrs); end
  def at_least_one_of(*attrs); end
  def build_with(build_with = nil); end
  def declared_param?(param); end
  def exactly_one_of(*attrs); end
  def first_hash_key_or_param(parameter); end
  def given(*attrs, &block); end
  def group(*attrs, &block); end
  def includes(*names); end
  def map_params(params, element, is_array = nil); end
  def mutually_exclusive(*attrs); end
  def optional(*attrs, &block); end
  def params(params); end
  def requires(*attrs, &block); end
  def use(*names); end
  def use_scope(*names); end
  def with(*attrs, &block); end
  extend ActiveSupport::Concern
end
class Grape::DSL::Parameters::EmptyOptionalValue
end
class Grape::Validations::ParamsScope
  def all_element_blank?(scoped_params); end
  def brackets(val); end
  def check_coerce_with(validations); end
  def check_incompatible_option_values(default, values, except_values, excepts); end
  def coerce_type(validations, attrs, doc_attrs, opts); end
  def configuration; end
  def configure_declared_params; end
  def derive_validator_options(validations); end
  def document_attribute(attrs, doc_attrs); end
  def element; end
  def element=(arg0); end
  def extract_message_option(attrs); end
  def full_name(name, index: nil); end
  def full_path; end
  def guess_coerce_type(coerce_type, *values_list); end
  def index; end
  def index=(arg0); end
  def infer_coercion(validations); end
  def initialize(opts, &block); end
  def lateral?; end
  def meets_dependency?(params, request_params); end
  def nested?; end
  def new_group_scope(attrs, &block); end
  def new_lateral_scope(options, &block); end
  def new_scope(attrs, optional = nil, &block); end
  def options_key?(type, key, validations); end
  def parent; end
  def parent=(arg0); end
  def push_declared_params(attrs, **opts); end
  def push_renamed_param(path, new_name); end
  def require_optional_fields(context, opts); end
  def require_required_and_optional_fields(context, opts); end
  def required?; end
  def root?; end
  def should_validate?(parameters); end
  def type; end
  def validate(type, options, attrs, doc_attrs, opts); end
  def validate_attributes(attrs, opts, &block); end
  def validate_value_coercion(coerce_type, *values_list); end
  def validates(attrs, validations); end
  def validates_presence(validations, attrs, doc_attrs, opts); end
  include Grape::DSL::Parameters
end
module DryTypes
  extend Anonymous_Dry_Core_Deprecations_Tagged_37
  extend Anonymous_Module_38
  extend Dry::Core::Deprecations::Interface
  extend Dry::Types::BuilderMethods
  include Anonymous_Dry_Types_Module_39
end
module DryTypes::Definition
end
module Anonymous_Dry_Types_Module_39
  def self.included(base); end
  extend Dry::Types::BuilderMethods
end
module Anonymous_Dry_Core_Deprecations_Tagged_37
end
module Anonymous_Module_38
  def const_missing(missing); end
end
module Grape::Validations::Types
  def self.build_coercer(type, method: nil, strict: nil); end
  def self.cache_instance(type, method, strict, &_block); end
  def self.cache_key(type, method, strict); end
  def self.collection_of_custom?(type); end
  def self.create_coercer_instance(type, method, strict); end
  def self.custom?(type); end
  def self.group?(type); end
  def self.map_special(type); end
  def self.multiple?(type); end
  def self.primitive?(type); end
  def self.special?(type); end
  def self.structure?(type); end
end
class Grape::Validations::Types::DryTypeCoercer
  def call(val); end
  def initialize(type, strict = nil); end
  def scope; end
  def self.coercer_instance_for(type, strict = nil); end
  def self.collection_coercer_for(type); end
  def self.collection_coercers; end
  def self.register_collection(type); end
  def strict; end
  def type; end
end
class Grape::Validations::Types::ArrayCoercer < Grape::Validations::Types::DryTypeCoercer
  def call(_val); end
  def coerce_elements(collection); end
  def elem_coercer; end
  def initialize(type, strict = nil); end
  def reject?(val); end
  def subtype; end
end
class Grape::Validations::Types::SetCoercer < Grape::Validations::Types::ArrayCoercer
  def call(value); end
  def coerce_elements(collection); end
  def initialize(type, strict = nil); end
end
class Grape::Validations::Types::PrimitiveCoercer < Grape::Validations::Types::DryTypeCoercer
  def call(val); end
  def initialize(type, strict = nil); end
  def reject?(val); end
  def treat_as_nil?(val); end
  def type; end
end
class Grape::Validations::Types::CustomTypeCoercer
  def call(val); end
  def coerced?(val); end
  def enforce_symbolized_keys(type, method); end
  def infer_coercion_method(type, method); end
  def infer_type_check(type); end
  def initialize(type, method = nil); end
  def recursive_type_check(type, value); end
  def symbolize_keys!(hash); end
  def symbolize_keys(hash); end
end
class Grape::Validations::Types::CustomTypeCollectionCoercer < Grape::Validations::Types::CustomTypeCoercer
  def call(value); end
  def initialize(type, set = nil); end
end
class Grape::Validations::Types::MultipleTypeCoercer
  def call(val); end
  def initialize(types, method = nil); end
end
class Grape::Validations::Types::VariantCollectionCoercer
  def call(value); end
  def initialize(types, method = nil); end
end
class Grape::Validations::Types::Json
  def self.coerced_collection?(value); end
  def self.parse(input); end
  def self.parsed?(value); end
end
class Grape::Validations::Types::JsonArray < Grape::Validations::Types::Json
  def self.parse(input); end
  def self.parsed?(value); end
end
class Grape::Validations::Types::File
  def self.parse(input); end
  def self.parsed?(value); end
end
class Grape::Validations::Types::InvalidValue
  def initialize(message = nil); end
  def message; end
end
module Grape::Types
end
class Grape::Types::InvalidValue < Grape::Validations::Types::InvalidValue
end
module Grape::Validations::Validators
end
class Grape::Validations::Validators::Base
  def attrs; end
  def fail_fast?; end
  def initialize(attrs, options, required, scope, *opts); end
  def message(default_key = nil); end
  def options_key?(key, options = nil); end
  def self.convert_to_short_name(klass); end
  def self.inherited(klass); end
  def validate!(params); end
  def validate(request); end
end
class Grape::Validations::Validators::AllowBlankValidator < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params); end
end
class Grape::Validations::Validators::AsValidator < Grape::Validations::Validators::Base
  def validate_param!(*arg0); end
end
class Grape::Validations::Validators::MultipleParamsBase < Grape::Validations::Validators::Base
  def all_keys; end
  def keys_in_common(resource_params); end
  def validate!(params); end
end
class Grape::Validations::Validators::AtLeastOneOfValidator < Grape::Validations::Validators::MultipleParamsBase
  def validate_params!(params); end
end
class Grape::Validations::Validators::CoerceValidator < Grape::Validations::Validators::Base
  def coerce_value(val); end
  def converter; end
  def initialize(attrs, options, required, scope, **opts); end
  def type; end
  def valid_type?(val); end
  def validate_param!(attr_name, params); end
  def validation_exception(attr_name, custom_msg = nil); end
end
class Grape::Validations::Validators::DefaultValidator < Grape::Validations::Validators::Base
  def duplicatable?(obj); end
  def duplicate(obj); end
  def initialize(attrs, options, required, scope, **opts); end
  def validate!(params); end
  def validate_param!(attr_name, params); end
end
class Grape::Validations::Validators::ExactlyOneOfValidator < Grape::Validations::Validators::MultipleParamsBase
  def validate_params!(params); end
end
class Grape::Validations::Validators::MutualExclusionValidator < Grape::Validations::Validators::MultipleParamsBase
  def validate_params!(params); end
end
class Grape::Validations::Validators::PresenceValidator < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params); end
end
class Grape::Validations::Validators::RegexpValidator < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params); end
end
class Grape::Validations::Validators::SameAsValidator < Grape::Validations::Validators::Base
  def build_message; end
  def validate_param!(attr_name, params); end
end
class Grape::Validations::Validators::ValuesValidator < Grape::Validations::Validators::Base
  def check_excepts(param_array); end
  def check_values(param_array, attr_name); end
  def except_message; end
  def initialize(attrs, options, required, scope, **opts); end
  def required_for_root_scope?; end
  def validate_param!(attr_name, params); end
  def validation_exception(attr_name, message); end
end
class Grape::Validations::Validators::ExceptValuesValidator < Grape::Validations::Validators::Base
  def initialize(attrs, options, required, scope, **opts); end
  def validate_param!(attr_name, params); end
end
class Grape::Validations::Validators::AllOrNoneOfValidator < Grape::Validations::Validators::MultipleParamsBase
  def validate_params!(params); end
end
class Grape::Validations::ValidatorFactory
  def self.create_validator(**options); end
end
module Grape::Exceptions
  extend ActiveSupport::Autoload
end
module Grape::Extensions::Hashie
  extend ActiveSupport::Autoload
end
module Grape::Presenters
  extend ActiveSupport::Autoload
end
module Grape::ServeStream
  extend ActiveSupport::Autoload
end
module Grape::DSL::Headers
  def header(key = nil, val = nil); end
  def headers(key = nil, val = nil); end
end
module Grape::DSL::InsideRoute
  def body(value = nil); end
  def configuration; end
  def content_type(val = nil); end
  def cookies; end
  def declared(*arg0); end
  def entity_class_for_obj(object, options); end
  def entity_representation_for(entity_class, object, options); end
  def error!(message, status = nil, additional_headers = nil); end
  def file(value = nil); end
  def present(*args); end
  def redirect(url, permanent: nil, body: nil, **_options); end
  def return_no_content; end
  def route; end
  def self.post_filter_methods(type); end
  def sendfile(value = nil); end
  def status(status = nil); end
  def stream(value = nil); end
  def version; end
  extend ActiveSupport::Concern
  include Grape::DSL::Headers
  include Grape::DSL::Settings
end
class Grape::DSL::InsideRoute::MethodNotYetAvailable < StandardError
end
module Grape::DSL::InsideRoute::PostBeforeFilter
  def declared(passed_params, options = nil, declared_params = nil, params_nested_path = nil); end
  def declared_array(passed_params, options, declared_params, params_nested_path); end
  def declared_hash(passed_params, options, declared_params, params_nested_path); end
  def handle_passed_param(params_nested_path, has_passed_children = nil, &_block); end
  def optioned_declared_params(**options); end
  def optioned_param_key(declared_param, options); end
end
class Grape::Endpoint
  def after_validations; end
  def afters; end
  def before_validations; end
  def befores; end
  def block; end
  def block=(arg0); end
  def build_helpers; end
  def build_stack(helpers); end
  def call!(env); end
  def call(env); end
  def endpoints; end
  def env; end
  def equals?(e); end
  def execute; end
  def finallies; end
  def headers; end
  def helpers; end
  def inherit_settings(namespace_stackable); end
  def initialize(new_settings, options = nil, &block); end
  def lazy_initialize!; end
  def map_routes; end
  def merge_route_options(**default); end
  def method_name; end
  def mount_in(router); end
  def namespace; end
  def options; end
  def options=(arg0); end
  def options?; end
  def params; end
  def prepare_default_route_attributes; end
  def prepare_path(path); end
  def prepare_routes_requirements; end
  def prepare_version; end
  def request; end
  def require_option(options, key); end
  def reset_routes!; end
  def routes; end
  def run; end
  def run_filters(filters, type = nil); end
  def run_validators(validator_factories, request); end
  def self.before_each(new_setup = nil, &block); end
  def self.generate_api_method(method_name, &block); end
  def self.new(*args, &block); end
  def self.run_before_each(endpoint); end
  def source; end
  def source=(arg0); end
  def to_routes; end
  def validations; end
  include Grape::DSL::InsideRoute
  include Grape::DSL::Settings
  include Grape::DSL::Settings
end
class Grape::Namespace
  def initialize(space, **options); end
  def options; end
  def requirements; end
  def self.joined_space(settings); end
  def self.joined_space_path(settings); end
  def space; end
end
class Grape::Namespace::JoinedSpaceCache < Grape::Util::Cache
  def initialize; end
end
module Grape::ErrorFormatter::Base
  def present(message, env); end
end
module Grape::ErrorFormatter::Json
  def self.call(message, backtrace, options = nil, env = nil, original_exception = nil); end
  def self.wrap_message(message); end
  extend Grape::ErrorFormatter::Base
end
module Grape::ErrorFormatter::Txt
  def self.call(message, backtrace, options = nil, env = nil, original_exception = nil); end
  extend Grape::ErrorFormatter::Base
end
module Grape::ErrorFormatter::Xml
  def self.call(message, backtrace, options = nil, env = nil, original_exception = nil); end
  extend Grape::ErrorFormatter::Base
end

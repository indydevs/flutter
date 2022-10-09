# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/tzinfo/all/tzinfo.rbi
#
# tzinfo-2.0.5

module TZInfo
  def self.eager_load!; end
end
module TZInfo::UntaintExt
end
class TZInfo::StringDeduper
  def create_hash(&block); end
  def dedupe(string); end
  def initialize; end
  def self.global; end
end
class TZInfo::ConcurrentStringDeduper < TZInfo::StringDeduper
  def create_hash(&block); end
end
class TZInfo::UnaryMinusGlobalStringDeduper
  def dedupe(string); end
end
class TZInfo::Timestamp
  def <=>(t); end
  def add_and_set_utc_offset(seconds, utc_offset); end
  def eql?(arg0); end
  def hash; end
  def initialize!(value, sub_second = nil, utc_offset = nil); end
  def initialize(value, sub_second = nil, utc_offset = nil); end
  def inspect; end
  def new_datetime(klass = nil); end
  def new_time(klass = nil); end
  def self.create(year, month = nil, day = nil, hour = nil, minute = nil, second = nil, sub_second = nil, utc_offset = nil); end
  def self.for(value, offset = nil); end
  def self.for_datetime(datetime, ignore_offset, target_utc_offset); end
  def self.for_time(time, ignore_offset, target_utc_offset); end
  def self.for_time_like(time_like, ignore_offset, target_utc_offset); end
  def self.for_timestamp(timestamp, ignore_offset, target_utc_offset); end
  def self.is_time_like?(value); end
  def self.new!(value, sub_second = nil, utc_offset = nil); end
  def self.utc(value, sub_second = nil); end
  def strftime(format); end
  def sub_second; end
  def sub_second_to_s; end
  def to_datetime; end
  def to_i; end
  def to_s; end
  def to_time; end
  def utc; end
  def utc?; end
  def utc_offset; end
  def value; end
  def value_and_sub_second_to_s(offset = nil); end
  include Comparable
end
module TZInfo::WithOffset
  def if_timezone_offset(result = nil); end
  def strftime(format); end
end
class TZInfo::DateTimeWithOffset < DateTime
  def clear_timezone_offset; end
  def downto(min); end
  def england; end
  def gregorian; end
  def italy; end
  def julian; end
  def new_start(start = nil); end
  def set_timezone_offset(timezone_offset); end
  def step(limit, step = nil); end
  def timezone_offset; end
  def to_time; end
  def upto(max); end
  include TZInfo::WithOffset
end
class TZInfo::TimeWithOffset < Time
  def clear_timezone_offset; end
  def dst?; end
  def getlocal(*args); end
  def gmtime; end
  def isdst; end
  def localtime(*args); end
  def round(ndigits = nil); end
  def set_timezone_offset(timezone_offset); end
  def timezone_offset; end
  def to_a; end
  def to_datetime; end
  def utc; end
  def zone; end
  include TZInfo::WithOffset
end
class TZInfo::TimestampWithOffset < TZInfo::Timestamp
  def self.set_timezone_offset(timestamp, timezone_offset); end
  def set_timezone_offset(timezone_offset); end
  def timezone_offset; end
  def to_datetime; end
  def to_time; end
  include TZInfo::WithOffset
end
class TZInfo::TimezoneOffset
  def ==(toi); end
  def abbr; end
  def abbreviation; end
  def base_utc_offset; end
  def dst?; end
  def eql?(toi); end
  def hash; end
  def initialize(base_utc_offset, std_offset, abbreviation); end
  def inspect; end
  def observed_utc_offset; end
  def std_offset; end
  def utc_offset; end
  def utc_total_offset; end
end
class TZInfo::TimezoneTransition
  def ==(tti); end
  def at; end
  def eql?(tti); end
  def hash; end
  def initialize(offset, previous_offset, timestamp_value); end
  def local_end_at; end
  def local_start_at; end
  def offset; end
  def previous_offset; end
  def timestamp_value; end
end
class TZInfo::TransitionRule
  def ==(r); end
  def at(offset, year); end
  def eql?(r); end
  def hash; end
  def hash_args; end
  def initialize(transition_at); end
  def transition_at; end
end
class TZInfo::DayOfYearTransitionRule < TZInfo::TransitionRule
  def ==(r); end
  def eql?(r); end
  def hash_args; end
  def initialize(day, transition_at); end
  def seconds; end
end
class TZInfo::AbsoluteDayOfYearTransitionRule < TZInfo::DayOfYearTransitionRule
  def ==(r); end
  def eql?(r); end
  def get_day(offset, year); end
  def hash_args; end
  def initialize(day, transition_at = nil); end
  def is_always_first_day_of_year?; end
  def is_always_last_day_of_year?; end
end
class TZInfo::JulianDayOfYearTransitionRule < TZInfo::DayOfYearTransitionRule
  def ==(r); end
  def eql?(r); end
  def get_day(offset, year); end
  def hash_args; end
  def initialize(day, transition_at = nil); end
  def is_always_first_day_of_year?; end
  def is_always_last_day_of_year?; end
end
class TZInfo::DayOfWeekTransitionRule < TZInfo::TransitionRule
  def ==(r); end
  def day_of_week; end
  def eql?(r); end
  def hash_args; end
  def initialize(month, day_of_week, transition_at); end
  def is_always_first_day_of_year?; end
  def is_always_last_day_of_year?; end
  def month; end
end
class TZInfo::DayOfMonthTransitionRule < TZInfo::DayOfWeekTransitionRule
  def ==(r); end
  def eql?(r); end
  def get_day(offset, year); end
  def hash_args; end
  def initialize(month, week, day_of_week, transition_at = nil); end
  def offset_start; end
end
class TZInfo::LastDayOfMonthTransitionRule < TZInfo::DayOfWeekTransitionRule
  def ==(r); end
  def eql?(r); end
  def get_day(offset, year); end
  def initialize(month, day_of_week, transition_at = nil); end
end
class TZInfo::AnnualRules
  def apply_rule(rule, from_offset, to_offset, year); end
  def dst_end_rule; end
  def dst_offset; end
  def dst_start_rule; end
  def initialize(std_offset, dst_offset, dst_start_rule, dst_end_rule); end
  def std_offset; end
  def transitions(year); end
end
module TZInfo::DataSources
end
class TZInfo::DataSources::TimezoneInfo
  def create_timezone; end
  def identifier; end
  def initialize(identifier); end
  def inspect; end
  def raise_not_implemented(method_name); end
end
class TZInfo::DataSources::DataTimezoneInfo < TZInfo::DataSources::TimezoneInfo
  def create_timezone; end
  def period_for(timestamp); end
  def periods_for_local(local_timestamp); end
  def raise_not_implemented(method_name); end
  def transitions_up_to(to_timestamp, from_timestamp = nil); end
end
class TZInfo::DataSources::LinkedTimezoneInfo < TZInfo::DataSources::TimezoneInfo
  def create_timezone; end
  def initialize(identifier, link_to_identifier); end
  def link_to_identifier; end
end
class TZInfo::DataSources::ConstantOffsetDataTimezoneInfo < TZInfo::DataSources::DataTimezoneInfo
  def constant_offset; end
  def constant_period; end
  def initialize(identifier, constant_offset); end
  def period_for(timestamp); end
  def periods_for_local(local_timestamp); end
  def transitions_up_to(to_timestamp, from_timestamp = nil); end
end
class TZInfo::DataSources::TransitionsDataTimezoneInfo < TZInfo::DataSources::DataTimezoneInfo
  def find_minimum_transition(&block); end
  def initialize(identifier, transitions); end
  def period_for(timestamp); end
  def periods_for_local(local_timestamp); end
  def transition_on_or_after_timestamp?(transition, timestamp); end
  def transitions; end
  def transitions_up_to(to_timestamp, from_timestamp = nil); end
end
class TZInfo::DataSources::CountryInfo
  def code; end
  def initialize(code, name, zones); end
  def inspect; end
  def name; end
  def zones; end
end
class TZInfo::DataSources::InvalidPosixTimeZone < StandardError
end
class TZInfo::DataSources::PosixTimeZoneParser
  def check_scan(s, pattern); end
  def get_offset_from_hms(h, m, s); end
  def get_seconds_after_midnight_from_hms(h, m, s); end
  def initialize(string_deduper); end
  def parse(tz_string); end
  def parse_rule(s, type); end
end
class TZInfo::DataSources::InvalidZoneinfoFile < StandardError
end
class TZInfo::DataSources::ZoneinfoReader
  def apply_rules_with_transitions(file, transitions, offsets, rules); end
  def apply_rules_without_transitions(file, first_offset, rules); end
  def check_read(file, bytes); end
  def derive_offsets(transitions, offsets); end
  def find_existing_offset(offsets, offset); end
  def initialize(posix_tz_parser, string_deduper); end
  def make_signed_int32(long); end
  def make_signed_int64(high, low); end
  def offset_matches_rule?(offset, rule_offset); end
  def parse(file); end
  def read(file_path); end
  def replace_with_existing_offsets(offsets, annual_rules); end
  def validate_and_fix_last_defined_transition_offset(file, last_defined, first_rule_offset); end
end
class TZInfo::InvalidDataSource < StandardError
end
class TZInfo::DataSourceNotFound < StandardError
end
class TZInfo::DataSource
  def build_timezone_identifiers; end
  def country_codes; end
  def data_timezone_identifiers; end
  def eager_load!; end
  def find_timezone_identifier(identifier); end
  def get_country_info(code); end
  def get_timezone_info(identifier); end
  def initialize; end
  def inspect; end
  def linked_timezone_identifiers; end
  def load_country_info(code); end
  def load_timezone_info(identifier); end
  def lookup_country_info(hash, code, encoding = nil); end
  def raise_invalid_data_source(method_name); end
  def self.create_default_data_source; end
  def self.get; end
  def self.set(data_source_or_type, *args); end
  def timezone_identifier_encoding; end
  def timezone_identifiers; end
  def to_s; end
  def try_with_encoding(string, encoding); end
  def validate_timezone_identifier(identifier); end
end
class TZInfo::DataSources::TZInfoDataNotFound < StandardError
end
class TZInfo::DataSources::RubyDataSource < TZInfo::DataSource
  def country_codes; end
  def data_timezone_identifiers; end
  def initialize; end
  def inspect; end
  def linked_timezone_identifiers; end
  def load_country_info(code); end
  def load_timezone_info(identifier); end
  def require_data(*file); end
  def require_definition(identifier); end
  def require_index(name); end
  def to_s; end
  def version_info; end
end
class TZInfo::DataSources::InvalidZoneinfoDirectory < StandardError
end
class TZInfo::DataSources::ZoneinfoDirectoryNotFound < StandardError
end
class TZInfo::DataSources::ZoneinfoDataSource < TZInfo::DataSource
  def country_codes; end
  def data_timezone_identifiers; end
  def dms_to_rational(sign, degrees, minutes, seconds = nil); end
  def enum_timezones(dir, exclude = nil, &block); end
  def find_zoneinfo_dir; end
  def initialize(zoneinfo_dir = nil, alternate_iso3166_tab_path = nil); end
  def inspect; end
  def linked_timezone_identifiers; end
  def load_countries(iso3166_tab_path, zone_tab_path); end
  def load_country_info(code); end
  def load_timezone_identifiers; end
  def load_timezone_info(identifier); end
  def resolve_tab_path(zoneinfo_path, standard_names, tab_name); end
  def self.alternate_iso3166_tab_search_path; end
  def self.alternate_iso3166_tab_search_path=(alternate_iso3166_tab_search_path); end
  def self.process_search_path(path, default); end
  def self.search_path; end
  def self.search_path=(search_path); end
  def to_s; end
  def validate_zoneinfo_dir(path, iso3166_tab_path = nil); end
  def zoneinfo_dir; end
end
class TZInfo::TimezonePeriod
  def abbr; end
  def abbreviation; end
  def base_utc_offset; end
  def dst?; end
  def end_transition; end
  def ends_at; end
  def initialize(offset); end
  def local_ends_at; end
  def local_starts_at; end
  def observed_utc_offset; end
  def offset; end
  def raise_not_implemented(method_name); end
  def start_transition; end
  def starts_at; end
  def std_offset; end
  def timestamp(transition); end
  def timestamp_with_offset(transition); end
  def utc_offset; end
  def utc_total_offset; end
  def zone_identifier; end
end
class TZInfo::OffsetTimezonePeriod < TZInfo::TimezonePeriod
  def ==(p); end
  def end_transition; end
  def eql?(p); end
  def hash; end
  def initialize(offset); end
  def start_transition; end
end
class TZInfo::TransitionsTimezonePeriod < TZInfo::TimezonePeriod
  def ==(p); end
  def end_transition; end
  def eql?(p); end
  def hash; end
  def initialize(start_transition, end_transition); end
  def inspect; end
  def start_transition; end
end
class TZInfo::AmbiguousTime < StandardError
end
class TZInfo::PeriodNotFound < StandardError
end
class TZInfo::InvalidTimezoneIdentifier < StandardError
end
class TZInfo::UnknownTimezone < StandardError
end
class TZInfo::Timezone
  def <=>(tz); end
  def =~(regexp); end
  def _dump(limit); end
  def abbr(time = nil); end
  def abbreviation(time = nil); end
  def base_utc_offset(time = nil); end
  def canonical_identifier; end
  def canonical_zone; end
  def current_period; end
  def current_period_and_time; end
  def current_time_and_period; end
  def dst?(time = nil); end
  def eql?(tz); end
  def friendly_identifier(skip_first_part = nil); end
  def hash; end
  def identifier; end
  def inspect; end
  def local_datetime(year, month = nil, day = nil, hour = nil, minute = nil, second = nil, sub_second = nil, dst = nil, &block); end
  def local_time(year, month = nil, day = nil, hour = nil, minute = nil, second = nil, sub_second = nil, dst = nil, &block); end
  def local_timestamp(year, month = nil, day = nil, hour = nil, minute = nil, second = nil, sub_second = nil, dst = nil, &block); end
  def local_to_utc(local_time, dst = nil); end
  def name; end
  def now; end
  def observed_utc_offset(time = nil); end
  def offsets_up_to(to, from = nil); end
  def period_for(time); end
  def period_for_local(local_time, dst = nil); end
  def period_for_utc(utc_time); end
  def periods_for_local(local_time); end
  def raise_unknown_timezone; end
  def self._load(data); end
  def self.all; end
  def self.all_country_zone_identifiers; end
  def self.all_country_zones; end
  def self.all_data_zone_identifiers; end
  def self.all_data_zones; end
  def self.all_identifiers; end
  def self.all_linked_zone_identifiers; end
  def self.all_linked_zones; end
  def self.data_source; end
  def self.default_dst; end
  def self.default_dst=(value); end
  def self.get(identifier); end
  def self.get_proxies(identifiers); end
  def self.get_proxy(identifier); end
  def strftime(format, time = nil); end
  def to_local(time); end
  def to_s; end
  def transitions_up_to(to, from = nil); end
  def utc_offset(time = nil); end
  def utc_to_local(utc_time); end
  include Comparable
end
class TZInfo::InfoTimezone < TZInfo::Timezone
  def identifier; end
  def info; end
  def initialize(info); end
end
class TZInfo::DataTimezone < TZInfo::InfoTimezone
  def canonical_zone; end
  def period_for(time); end
  def periods_for_local(local_time); end
  def transitions_up_to(to, from = nil); end
end
class TZInfo::LinkedTimezone < TZInfo::InfoTimezone
  def canonical_zone; end
  def initialize(info); end
  def period_for(time); end
  def periods_for_local(local_time); end
  def transitions_up_to(to, from = nil); end
end
class TZInfo::TimezoneProxy < TZInfo::Timezone
  def _dump(limit); end
  def canonical_zone; end
  def identifier; end
  def initialize(identifier); end
  def period_for(time); end
  def periods_for_local(local_time); end
  def real_timezone; end
  def self._load(data); end
  def transitions_up_to(to, from = nil); end
end
class TZInfo::InvalidCountryCode < StandardError
end
class TZInfo::Country
  def <=>(c); end
  def =~(regexp); end
  def _dump(limit); end
  def code; end
  def eql?(c); end
  def hash; end
  def initialize(info); end
  def inspect; end
  def name; end
  def self._load(data); end
  def self.all; end
  def self.all_codes; end
  def self.data_source; end
  def self.get(code); end
  def to_s; end
  def zone_identifiers; end
  def zone_info; end
  def zone_names; end
  def zones; end
  include Comparable
end
class TZInfo::CountryTimezone
  def ==(ct); end
  def description; end
  def description_or_friendly_identifier; end
  def eql?(ct); end
  def hash; end
  def identifier; end
  def initialize(identifier, latitude, longitude, description = nil); end
  def latitude; end
  def longitude; end
  def timezone; end
end
module TZInfo::Format2
end
class TZInfo::Format2::CountryDefiner
  def initialize(shared_timezones, identifier_deduper, description_deduper); end
  def timezone(identifier_or_reference, latitude_numerator = nil, latitude_denominator = nil, longitude_numerator = nil, longitude_denominator = nil, description = nil); end
  def timezones; end
end
class TZInfo::Format2::CountryIndexDefiner
  def countries; end
  def country(code, name); end
  def initialize(identifier_deduper, description_deduper); end
  def timezone(reference, identifier, latitude_numerator, latitude_denominator, longitude_numerator, longitude_denominator, description = nil); end
end
module TZInfo::Format2::CountryIndexDefinition
  def self.append_features(base); end
end
module TZInfo::Format2::CountryIndexDefinition::ClassMethods
  def countries; end
  def country_index; end
end
class TZInfo::Format2::TimezoneDefiner
  def first_offset; end
  def initialize(string_deduper); end
  def offset(id, base_utc_offset, std_offset, abbreviation); end
  def subsequent_rules(*args); end
  def transition(offset_id, timestamp_value); end
  def transitions; end
end
module TZInfo::Format2::TimezoneDefinition
  def self.append_features(base); end
end
module TZInfo::Format2::TimezoneDefinition::ClassMethods
  def get; end
  def linked_timezone(identifier, link_to_identifier); end
  def timezone(identifier); end
  def timezone_definer_class; end
end
class TZInfo::Format2::TimezoneIndexDefiner
  def data_timezone(identifier); end
  def data_timezones; end
  def initialize(string_deduper); end
  def linked_timezone(identifier); end
  def linked_timezones; end
end
module TZInfo::Format2::TimezoneIndexDefinition
  def self.append_features(base); end
end
module TZInfo::Format2::TimezoneIndexDefinition::ClassMethods
  def data_timezones; end
  def linked_timezones; end
  def timezone_index; end
end
module TZInfo::Format1
end
class TZInfo::Format1::CountryDefiner < TZInfo::Format2::CountryDefiner
  def initialize(identifier_deduper, description_deduper); end
end
module TZInfo::Format1::CountryIndexDefinition
  def self.append_features(base); end
end
module TZInfo::Format1::CountryIndexDefinition::ClassMethods
  def countries; end
  def country(code, name); end
end
class TZInfo::Format1::TimezoneDefiner < TZInfo::Format2::TimezoneDefiner
  def offset(id, utc_offset, std_offset, abbreviation); end
  def transition(year, month, offset_id, timestamp_value, datetime_numerator = nil, datetime_denominator = nil); end
end
module TZInfo::Format1::TimezoneDefinition
  def self.append_features(base); end
end
module TZInfo::Format1::TimezoneDefinition::ClassMethods
  def timezone_definer_class; end
end
module TZInfo::Format1::TimezoneIndexDefinition
  def self.append_features(base); end
end
module TZInfo::Format1::TimezoneIndexDefinition::ClassMethods
  def data_timezones; end
  def linked_timezone(identifier); end
  def linked_timezones; end
  def timezone(identifier); end
end

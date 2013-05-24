require 'active_model'

module Payflow
  class CreditCard
    include ActiveModel::Validations
    validates_with CreditCardValidator

    attr_accessor :number
    attr_accessor :month
    attr_accessor :year
    attr_accessor :brand
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :security_code
    attr_accessor :encrypted_track_data

    # used for the gateway most likely
    attr_accessor :SWIPEDECRHOST
    attr_accessor :MAGTEKCARDTYPE
    attr_accessor :REGISTEREDBY
    attr_accessor :ENCRYPTIONBLOCKTYPE

    attr_accessor :enctrack2
    attr_accessor :encmp
    attr_accessor :ksn
    attr_accessor :mpstatus


    def initialize(options = {})
      @number = options[:number]
      @month  = options[:month]
      @year   = options[:year]
      @first_name = options[:first_name]
      @last_name  = options[:last_name]
      @encrypted_track_data = options[:encrypted_track_data]

      parse_encryption if encrypted?
    end

    def expiry_date
      ExpiryDate.new(@month, @year)
    end

    def expired?
      expiry_date.expired?
    end

    def encrypted?
      encrypted_track_data.present?
    end

    def display_number
      self.class.mask(number)
    end

    def self.mask(number)
      "XXXX-XXXX-XXXX-#{last_digits(number)}"
    end

    def self.last_digits(number)
      number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
    end

    private
      def parse_encryption
        self.enctrack2 = "2q52345"
        self.ksn = "sadfgsdfgfd"
        self.mpstatus = "ASDgfds"
        self.encmp = "asdgfsd"
        self.month = 11
        self.year = 2020
      end

  end
end
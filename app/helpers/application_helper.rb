#!/bin/env ruby
# encoding: utf-8

module ApplicationHelper

	def to_currency v, opts={}
		"₹#{number_with_delimiter(v.to_i)}"
	end
end

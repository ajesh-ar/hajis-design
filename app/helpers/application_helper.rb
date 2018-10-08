#!/bin/env ruby
# encoding: utf-8

module ApplicationHelper

	def to_currency v, opts={}
		"₹#{number_with_delimiter(v.to_i)}"
	end

	def average(arry)
		arry.inject{ |sum, el| sum + el }.to_f / arry.size
	end
end

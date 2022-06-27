# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Checkout do
  let(:incorrect_code) { 'GB1' }
  let(:checkout) { Checkout.new }

  describe '#total' do
    context 'when basket#1' do
      before do
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::STRAWBERRY_CODE)
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::COFFEE_CODE)
      end
      it 'calcutates right total' do
        expect(checkout.total).to eq(22.45)
      end
    end

    context 'when basket#2' do
      before do
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::TEA_CODE)
      end
      it 'calcutates right total' do
        expect(checkout.total).to eq(3.11)
      end
    end

    context 'when basket#3' do
      before do
        checkout.scan(Items::STRAWBERRY_CODE)
        checkout.scan(Items::STRAWBERRY_CODE)
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::STRAWBERRY_CODE)
      end
      it 'calcutates right total' do
        expect(checkout.total).to eq(16.61)
      end
    end

    context 'when basket#4' do
      before do
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::COFFEE_CODE)
        checkout.scan(Items::STRAWBERRY_CODE)
        checkout.scan(Items::COFFEE_CODE)
        checkout.scan(Items::COFFEE_CODE)
      end
      it 'calcutates right total' do
        expect(checkout.total).to eq(30.57)
      end
    end

    context 'when basket with incorrect item' do
      before do
        checkout.scan(Items::TEA_CODE)
        checkout.scan(Items::COFFEE_CODE)
        checkout.scan(Items::STRAWBERRY_CODE)
        checkout.scan(Items::COFFEE_CODE)
        checkout.scan(incorrect_code)
        checkout.scan(Items::COFFEE_CODE)
      end
      it 'skips incorrect item and calcutates right total' do
        expect(checkout.total).to eq(30.57)
      end
    end

    context 'when basket is empty' do
      before do
      end
      it 'calcutates right total' do
        expect(checkout.total).to eq(0)
      end
    end
  end

  describe '#scan' do
    context 'when adding to empty basket' do
      context 'key is existed in meta' do
        it 'adds to basket' do
          expect(checkout.scan(Items::TEA_CODE)).to eq([Items::TEA_CODE])
        end
      end

      context 'key doesn\'t existed in meta' do
        it 'doesn\'t add to basket' do
          expect(checkout.scan(incorrect_code)).to eq(nil)
        end
      end
    end

    context 'when adding to basket with items' do
      before do
        checkout.scan(Items::STRAWBERRY_CODE)
      end

      context 'key is existed in meta' do
        it 'adds to basket' do
          expect(checkout.scan(Items::TEA_CODE)).to eq([Items::STRAWBERRY_CODE, 
            Items::TEA_CODE])
        end
      end

      context 'key doesn\'t existed in meta' do
        it 'doesn\'t add to basket' do
          expect(checkout.scan(incorrect_code)).to eq(nil)
        end
      end
    end
  end
end

# frozen_string_literal: true

control 'rstudio package' do
  title 'should be installed'

  describe package('rstudio') do
    it { should be_installed }
  end
end

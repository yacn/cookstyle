# frozen_string_literal: true
#
# Copyright:: 2021, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe RuboCop::Cop::Chef::Modernize::DependsOnKernelModuleCookbook, :config do
  it 'registers an offense when depending on the kernel_module cookbook' do
    expect_offense(<<~RUBY)
      depends 'kernel_module'
      ^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on the kernel_module cookbook made obsolete by Chef Infra Client 14.3. The kernel_module resource is now included in Chef Infra Client itself.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when depending on other cookbooks" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end

  context 'with TargetChefVersion set to 14.2' do
    let(:config) { target_chef_version(14.2) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        depends 'kernel_module'
      RUBY
    end
  end
end

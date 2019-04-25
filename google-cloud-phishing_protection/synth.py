# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""This script is used to synthesize generated parts of this library."""

import synthtool as s
import synthtool.gcp as gcp
import synthtool.languages.ruby as ruby
import logging
import os
import re
from subprocess import call


logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v1beta1_library = gapic.ruby_library(
    'phishingprotection', 'v1beta1', artman_output_name='google-cloud-ruby/google-cloud-phishingprotection',
    config_path='artman_phishingprotection_v1beta1.yaml'
)

s.copy(v1beta1_library / 'lib')
s.copy(v1beta1_library / 'test')
s.copy(v1beta1_library / 'acceptance')
s.copy(v1beta1_library / 'README.md')
s.copy(v1beta1_library / 'LICENSE')
s.copy(v1beta1_library / '.gitignore')
s.copy(v1beta1_library / '.yardopts')
s.copy(v1beta1_library / 'google-cloud-phishing_protection.gemspec', merge=ruby.merge_gemspec)

# Copy common templates
templates = gcp.CommonTemplates().ruby_library()
s.copy(templates)

# https://github.com/googleapis/gapic-generator/issues/2180
s.replace(
    'google-cloud-phishing_protection.gemspec',
    '\n  gem\\.add_dependency "google-gax", "~> ([\\d\\.]+)"\n\n',
    '\n  gem.add_dependency "google-gax", "~> \\1"\n  gem.add_dependency "grpc-google-iam-v1", "~> 0.6.9"\n\n')

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('^([^`]*(`[^`]*`[^`]*)*)([^`#\\$\\\\])\\{([\\w,]+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\3\\\\\\\\{\\4}', content)
        if count == 0:
            return content
s.replace(
    'lib/google/cloud/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/phishing_protection/*/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/**/*.rb',
    '\\A(((#[^\n]*)?\n)*# (Copyright \\d+|Generated by the protocol buffer compiler)[^\n]+\n(#[^\n]*\n)*\n)([^\n])',
    '\\1\n\\6')

# https://github.com/googleapis/gapic-generator/issues/2323
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://github\\.com/GoogleCloudPlatform/google-cloud-ruby',
    'https://github.com/googleapis/google-cloud-ruby'
)
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://googlecloudplatform\\.github\\.io/google-cloud-ruby',
    'https://googleapis.github.io/google-cloud-ruby'
)

# https://github.com/googleapis/gapic-generator/issues/2393
s.replace(
    'google-cloud-phishing_protection.gemspec',
    'gem.add_development_dependency "rubocop".*$',
    'gem.add_development_dependency "rubocop", "~> 0.64.0"'
)

s.replace(
    'google-cloud-phishing_protection.gemspec',
    'gem.add_dependency "google-gax", "~> 1.3"',
    "\n".join([
        'gem.add_dependency "google-gax", "~> 1.3"',
        '  gem.add_dependency "googleapis-common-protos", ">= 1.3.9", "< 2.0"'
    ])
)

os.rename(
    'lib/google/cloud/phishing_protection/v1beta1/phishing_protection_service_v1_beta1_client_config.json',
    'lib/google/cloud/phishing_protection/v1beta1/phishing_protection_client_config.json'
)
os.rename(
    'lib/google/cloud/phishing_protection/v1beta1/phishing_protection_service_v1_beta1_client.rb',
    'lib/google/cloud/phishing_protection/v1beta1/phishing_protection_client.rb'
)
os.rename(
    'test/google/cloud/phishing_protection/v1beta1/phishing_protection_service_v1_beta1_client_test.rb',
    'test/google/cloud/phishing_protection/v1beta1/phishing_protection_client_test.rb'
)
s.replace(
    'lib/**/*.rb',
    '_service_v1_beta1',
    ''
)
s.replace(
    'lib/**/*.rb',
    'ServiceV1Beta1',
    ''
)
s.replace(
    'lib/**/*.rb',
    '"google.cloud.phishingprotection.v1beta1.PhishingProtection"',
    '"google.cloud.phishingprotection.v1beta1.PhishingProtectionServiceV1Beta1"'
)
s.replace(
    'lib/**/credentials.rb',
    'PHISHINGPROTECTION_',
    'PHISHING_PROTECTION_'
)

s.replace(
    'test/**/*.rb',
    '_service_v1_beta1',
    ''
)
s.replace(
    'test/**/*.rb',
    'ServiceV1Beta1',
    ''
)

# Require the helpers file
s.replace(
    f'lib/google/cloud/phishing_protection/v1beta1.rb',
    f'require "google/cloud/phishing_protection/v1beta1/phishing_protection_client"',
    '\n'.join([
        f'require "google/cloud/phishing_protection/v1beta1/phishing_protection_client"',
        f'require "google/cloud/phishing_protection/v1beta1/helpers"'
    ])
)

s.replace(
    'google-cloud-phishing_protection.gemspec',
    '"README.md", "LICENSE"',
    '"README.md", "AUTHENTICATION.md", "LICENSE"'
)
s.replace(
    '.yardopts',
    'README.md\n',
    'README.md\nAUTHENTICATION.md\nLICENSE\n'
)

# Generate the helper methods
call('bundle update && bundle exec rake generate_partials', shell=True)

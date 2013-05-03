# SummarizeCodes

Convert a set of CSV code counts into the JSON format expected by the analyze_codes script

## Installation

Check out the code from GitHub, then:

    cd summarize_codes
    bundle install

## Usage

    bundle exec rake codes:summarize['/path/to/folder/containing/csv/files']

Results are written to `./tmp`.

## License

Copyright (c) The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
 except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the
License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
either express or implied. See the License for the specific language governing permissions 
and limitations under the License.
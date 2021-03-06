#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#
module CC::Importer::Canvas
  module WikiConverter
    include CC::Importer
    
    def convert_wikis
      wikis = []
      
      wiki_dir = File.join(@unzipped_file_path, WIKI_FOLDER)
      Dir["#{wiki_dir}/**/**"].each do |path|
        doc = open_file(path)
        wikis << convert_wiki(doc, path)
      end
      
      wikis
    end
    
    def convert_wiki(doc, path)
      wiki = {}
      wiki_name = File.basename(path).sub(".html", '')
      title, body, id = get_html_title_and_body_and_id(doc)
      wiki[:title] = title
      wiki[:migration_id] = id
      wiki[:text] = body
      wiki[:url_name] = wiki_name
      wiki
    end
    
  end
end

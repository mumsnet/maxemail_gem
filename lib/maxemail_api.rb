module MaxemailApi
  class << self
    require 'base64'
    require 'http'
    require 'json'

    def send(params)
      params[:email_id] = email_id(folder_name: params[:folder_name], email_name: params[:email_name]) if params[:email_id].nil?
      send_triggered(email_address: params[:email_address], email_id: params[:email_id], profile_data: params[:profile_data])
    end

    private

    def fetch_root(tree: 'email', children: '[]')
      HTTP.headers(authentication_header)
          .get("#{ENV['MAXEMAIL_API_URL']}tree",
               params: {
                 method: 'fetchRoot',
                 tree: tree,
                 children: children
               })
    end

    def fetch_tree(tree: 'email', node_id: nil, node_class: 'folder')
      HTTP.headers(authentication_header)
          .get("#{ENV['MAXEMAIL_API_URL']}tree",
               params: {
                 method: 'fetchTree',
                 tree: tree,
                 nodeId: node_id,
                 nodeClass: node_class
               })
    end

    def fetch_trigged(folder_id: nil)
      HTTP.headers(authentication_header)
          .get("#{ENV['MAXEMAIL_API_URL']}email_triggered",
               params: {
                 method: 'fetchAll',
                 folderId: folder_id
               })
    end

    def send_triggered(email_address: nil, email_id: nil, profile_data: nil)
      HTTP.headers(authentication_header)
          .get("#{ENV['MAXEMAIL_API_URL']}email_send",
               params: {
                 method: 'trigger',
                 emailAddress: email_address,
                 emailId: email_id,
                 profileData: profile_data
               })
    end

    def folder_id(folder_name: nil)
      response = JSON.parse(fetch_root)
      response[0]['children'].map do |node|
        node['nodeId'].to_i if node['text'] == folder_name
      end.compact.first
    end

    def email_id(folder_name: nil, email_name: nil)
      folder_id = folder_id(folder_name: folder_name)
      response = JSON.parse(fetch_tree(tree: 'email', node_id: folder_id, node_class: 'folder'))
      response.map do |node|
        node['nodeId'].to_i if node['text'] == email_name
      end.compact.first
    end

    def authentication_header
      { Authorization: 'Basic ' + Base64.encode64(ENV['MAXEMAIL_USERNAME'] + ':' + ENV['MAXEMAIL_PASSWORD']).remove("\n") }
    end
  end
end

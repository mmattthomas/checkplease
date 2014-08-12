#json.extract! @task_item, :id, :created_at, :updated_at #, :message
json.set! :message, @message

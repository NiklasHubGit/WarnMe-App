def send_fcm_notification(access_token, device_token, title, body):
    url = "https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send"
    headers = {
        "Authorization": f"Bearer {access_token}",
        "Content-Type": "application/json"
    }

    payload = {
        "message": {
            "token": device_token,
            "notification": {
                "title": title,
                "body": body
            }
        }
    }


# Replace 'user_device_token' with the recipient device token
device_token = "fZ6XUTdkTw6uraSiT8Wk5Q:APA91bGn8zuzTxsyy7eYgFs5pkQxQg6fSGZOynox_E7b-6Ywqrm6h7VfyeioCicm7VvWJ1zbOhr-1d5ljNRAaewwFFKbZXCBgfsG1Mpf_H-3mz6BxRk8kiFizYcd9a393e6clXzNtPr-"

# Customize the notification title and body
notification_title = "Test Notification"
notification_body = "This is a test notification message."

# Send the FCM notification
send_fcm_notification(generate_access_token('hochwasserwarnapp-4b01ebd06065.json'), device_token, notification_title, notification_body)


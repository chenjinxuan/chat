from django import http


def find_user(req, user_id):
    return http.HttpResponse(user_id)


def add_user(req, user_id):
    pass

def agree_add_friend_request(req, user_id):
    pass
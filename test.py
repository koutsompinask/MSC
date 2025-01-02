import instaloader
import time

# Initialize Instaloader
L = instaloader.Instaloader()

# Log in to your account
username = "koutsompinas_"
password = "Panatha2002"
L.login(username, password)
time.sleep(5)

# Load profile
profile = instaloader.Profile.from_username(L.context, username)
time.sleep(5)

# Get followers and followees
followers = set(f.username for f in profile.get_followers())
time.sleep(5)


followees = set(f.username for f in profile.get_followees())
time.sleep(5)
# Find differences
not_following_back = followees - followers
not_followed_by = followers - followees

# Output results
print("People you follow who don't follow you back:")
print(not_following_back)

print("\nPeople who follow you but you don't follow back:")
print(not_followed_by)

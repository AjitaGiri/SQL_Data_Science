import json
def load_data():
    try:
        with open('youtube.txt','r') as file:
           return json.load(file)
    except FileNotFoundError:
        return []
    
def save_video_helper(videos):
    with open('youtube.txt','w') as file:
        return json.dump(videos,file)

def list_all_videos(videos):
    print("\n")
    print("*"*40)
    for index,video in enumerate(videos,start=1):
        print(f"{index}.{video['name']}, Duration:{video['time']}")
    print("*"*40)

def add_video(videos):
    name=input('Enter the name: ')
    time=input('Enter the length of video: ')
    videos.append({'name':name,'time': time})
    save_video_helper(videos)

def update_video(videos):
    list_all_videos(videos)
    index=int(input('Enter the number of video to be updated: '))

    if 1<= index <= len(videos):
        name=input("Enter the name of video: ")
        time=input("Enter the length of video: ")
        videos[index-1]={'name':name,'time':time}
        save_video_helper(videos)
    else:
        print('Invalid index is selected')


def delete_video(videos):
    list_all_videos(videos)
    index=int(input('Enter the number of the video to be deleted: '))
    if 1<=index<=len(videos):
        del videos[index-1]
        save_video_helper(videos)
    else:
        print('Invalid index selected')


videos=[]
def main():
    videos=load_data()
    while True:
        print("1.List all the videos")
        print("2.Add the youtube video")
        print("3.Update the youtube video")
        print("4.Delete the youtube video")
        print("5.Exit the app")
        choice=input("Enter the choice: ")

        match choice:
            case '1':
                list_all_videos(videos)
            case '2':
                add_video(videos)
            case '3':
                update_video(videos)
            case '4':
                delete_video(videos)
            case '5':
                break
            case _:
                print("Invalid choice selected")

if __name__=='__main__':
    main()
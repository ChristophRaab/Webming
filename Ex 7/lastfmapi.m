
user = [];
artists = [];
ua = [];
reg = [];
options = weboptions('Timeout',10);

getArtists = "http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=rj&api_key=c902e0327748608469ab6367154fd106&format=json";

response = webread(getArtists,options);

user = [ user; "rj"];

artistCount = size(response.topartists.artist,1);

for i=1:artistCount
    
    artist = string(response.topartists.artist(i,1).name);
    
    
    if i > 2
        idx = find(cellfun('length',regexp(artists,artist)) == 1);

        if isempty(idx) == 1
            artists = [artists artist];
            artIdx = size(ua,2)+1;
            ua(1,artIdx) = 1;
        else
            ua(1,idx) = 1;
        end
    else
         artists = [artists artist];
         ua(1,i) = 1;
    end
    
   
end

n = 1;

while(size(ua,1)< 1000)
    nextUser = user(n,1)
    getFriends = "http://ws.audioscrobbler.com/2.0/?method=user.getfriends&user="+nextUser+"&api_key=c902e0327748608469ab6367154fd106&format=json&limit=100";

    userfriends = webread(getFriends,options);

    sizeFriends = size(userfriends.friends.user,1);

    for j=1:sizeFriends 

        name = string(userfriends.friends.user{j, 1}.name)
      

                user = [ user; name];
                getArtists = "http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user="+name+"&api_key=c902e0327748608469ab6367154fd106&format=json";

                response = webread(getArtists,options);

                artistCount = size(response.topartists.artist,1);

                for i=1:artistCount

                    artist = string(response.topartists.artist(i,1).name);

                    idx = find(cellfun('length',regexp(artists,artist)) == 1);

                        if isempty(idx) == 1
                            artists = [artists artist];
                            artIdx = size(ua,2)+1;
                            ua(j+1,artIdx) = 1;
                        else
                            ua(j+1,idx) = 1;
                        end

                end
                reg = [reg;size(ua)];
    end
    n = n + 1;
end


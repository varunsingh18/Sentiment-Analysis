install.packages("devtools")
install.packages("ROAuth")
library(ROAuth)
library(devtools)
install_github("geoffjentry/twitteR")
library(twitteR)
install.packages("rtweet")
library(rtweet)
devtools::install_github("mkearney/rtweet")
library(syuzhet)
# Save Key
api_key <- 'AV4Lu87cRqL0lbGyCXH1Ys326'
api_secret <- '79I7qWjsU9NamrL085k3D5FyEwR8asiRavWmUFkNA8jifmoLCV'
access_token <- '124415925-s7ltnhYdeP0Rb8y09gvbMqDysZukyM1XIc0uWX7h'
access_token_secret <- '4tGtkRgaOdhPvluOmqF83Kg3hPFl39yg7vMPIPUZAVUsK'
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)


keywords <- c("mass shooting","shot dead","shot in school","gun related voilence","school shootings")
tweets <- searchTwitter(keywords[5], n=15000, include_rts= FALSE)
tweets <- rbind(tweets, searchTwitter(keywords[5], n=1500))
df <- do.call("rbind", lapply(tweets, as.data.frame))
View(df)
write.csv(df, file='df.csv', row.names = F)





#df3<-(df3$location %in% df1)



#df<-df[!is.na(df$location),]
#df <- df[-c(1,9)]
#df <- df[-c(9:10)]
View(df)
write.csv(df, file='twitter.csv', row.names = F)
df <- read.csv("twitter.csv", header=T, na.strings="")

#Read youtube data file
data_tw <- read.csv(file.choose(), header = T)
str(data_tw)
View(data_tw)

# Sentiment analysis
library(syuzhet)

# Read data file
data_tw <- read.csv(file.choose(), header = TRUE)
str(data_tw)
text_tw <- iconv(data_tw$text, to = 'utf-8')

# Obtain sentiment scores
s_tw <- get_nrc_sentiment(text_tw)
head(s_tw)
s_tw$neutral <- ifelse(s_tw$negative+s_tw$positive==0, 1, 0)
write.csv(s_tw, file='twitter_read.csv', row.names = F)

new_tw <- data.frame(s_tw$neutral, s_tw$negative, s_tw$positive)
write.csv(s_tw, file='twitter_read.csv', row.names = F)
head(new_tw)
View(new_tw)


# Bar plot 
barplot(100*colSums(s_tw)/sum(s_tw),
        las = 2,
        col = rainbow(10),
        ylab = 'Percentage',
        main = 'Sentiment Scores for Youtube Comments')

# # -*- coding: utf-8 -*-
# from flask import Flask, jsonify, request
# import pandas as pd
# from pandas import json_normalize
# import requests
# import json
# import spacy
# import numpy as np
# import nltk
# nltk.download('punkt')
# from nltk.tokenize import sent_tokenize
# from sklearn.feature_extraction.text import TfidfVectorizer
# from sklearn.metrics.pairwise import cosine_similarity
# import networkx as nx

# app = Flask(_name_)

# @app.route('/generatSumry', methods=['get'])
# def get_posts():
#     api_response = requests.get('https://fair-gold-duck-hat.cyclic.app/posts/get-all-post/')
#     data = api_response.text
#     parse_json = json.loads(data)    
#     df = json_normalize(parse_json['data']) 
#     df2 = df[["desc","_id"]]
#     df2=df2.fillna("But a Hindu advocacy group says the ordinance unfairly singles out and targets an entire community")
#     nlp = spacy.load("en_core_web_lg")
#     M = np.zeros((df2.shape[0], df2.shape[0]))
#     for i, row in df2.iterrows():
#         for j, next_row in df2.iterrows():
#             M[i, j] = nlp(row.title).similarity(nlp(next_row.title))
#     labels = df2.title
#     similarity_df = pd.DataFrame(M, columns=labels)
#     num_articles = len(parse_json['articles'])
#     postss = [[] for _ in range(num_articles)]
#     postsOfId = [[] for _ in range(num_articles)]
#     for i in range(similarity_df.shape[1]):
#         for post in range(similarity_df.shape[0]):
#             if similarity_df[df2.title[i]][post]>0.6:
#                 postsOfId[i].append(post)
#                 postss[i].append(df2.title[post])
#     postsslist =[]
#     postssOfIdlist =[]
#     for i in postss:
#         if len(i) > 1 :
#             postsslist.append(i)
#     for i in postsOfId:
#         if len(i) > 1 :
#             postssOfIdlist.append(i)        
#     summarylist=[]
#     for document in postsslist:
#         sentences = []
#         for doc in document:
#             sentences.extend(sent_tokenize(doc))
#         vectorizer = TfidfVectorizer(stop_words='english')
#         sentence_vectors = vectorizer.fit_transform(sentences)
#         similarity_matrix = cosine_similarity(sentence_vectors)
#         nx_graph = nx.from_numpy_array(similarity_matrix)
#         scores = nx.pagerank(nx_graph)
#         ranked_sentences = sorted(((scores[i],s) for i,s in enumerate(sentences)), reverse=True)
#         N = 2
#         summary_sentences = []
#         for i in range(N):
#             summary_sentences.append(ranked_sentences[i][1])
#         summary = ' '.join(summary_sentences)
#         summarylist.append(summary)
#     for i, post in enumerate(summarylist):
#         summarylist[i] = {
#             'postgenereted': post,
#             'generatfrom': postssOfIdlist[i]
#         }
#     return jsonify({'posts': summarylist})

# @app.route('/addPost', methods=['post'])
# def getPost():
#     post = request.get_json()
#     result = process_data(post)
#     return jsonify(result)

# def process_data(post):
#     api_response = requests.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=25568337eb8044f28399e141d4acf713')
#     data = api_response.text
#     listSumarisPost = json.loads(data)
#     nlp = spacy.load("en_core_web_lg")
#     similarities = []
#     for summary in listSumarisPost:
#         similarity = nlp(post).similarity(nlp(summary))
#         similarities.append(similarity)
#     max_value = max(similarities)
#     if max_value >0.5:
#         generetedPost=listSumarisPost[similarities.index(max_value)]
#         summarylist=[]
#         for document in [post,generetedPost]:
#             sentences = []
#             for doc in document:
#                 sentences.extend(sent_tokenize(doc))
#             vectorizer = TfidfVectorizer(stop_words='english')
#             sentence_vectors = vectorizer.fit_transform(sentences)
#             similarity_matrix = cosine_similarity(sentence_vectors)
#             nx_graph = nx.from_numpy_array(similarity_matrix)
#             scores = nx.pagerank(nx_graph)
#             ranked_sentences = sorted(((scores[i],s) for i,s in enumerate(sentences)), reverse=True)
#             N = 2
#             summary_sentences = []
#             for i in range(N):
#                 summary_sentences.append(ranked_sentences[i][1])
#             summary = ' '.join(summary_sentences)
#             summarylist.append(summary)
#         listSumarisPost[similarities.index(max_value)]=summarylist  

# if _name_ == '_main_':
#     app.run(debug=True)
    
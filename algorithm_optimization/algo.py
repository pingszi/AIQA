import warnings
warnings.filterwarnings(action='ignore', category=UserWarning, module='gensim')

from gensim import corpora, similarities, models
import xlrd
import re
import jieba
import time

start = time.clock()

jieba.load_userdict("keyword.txt")   # 外部字典

data = xlrd.open_workbook('saving.xlsx').sheets()[0]
nrows = data.nrows


def jieba_lcut(sentence, keyword):
    w = []
    words = list(jieba.lcut(sentence))
    for word in words:
        if word in keyword:
            w.append(word)
    return w


keyword = []
with open('keyword.txt', 'r', encoding='utf8') as f:
    for word in f:
        keyword.append(word.strip())
f.close()

pattern = re.compile(r'\[([^\[\]]*?)\]')
whole_cor = []
corpora_documents = []
# with open('whole_cor.txt', 'wt', encoding='utf8') as f:
for line in range(1, nrows):
    list_keyword = []
    corpora_documents.append(data.row_values(line)[2].strip())
    j_cut = jieba_lcut(data.row_values(line)[2].strip(), keyword)
    list_keyword += pattern.findall(data.row_values(line)[4].strip())
    list_keyword += j_cut
    whole_cor.append(list_keyword)
f.close()
#
dictionary = corpora.Dictionary(whole_cor)
corpus = [dictionary.doc2bow(text) for text in whole_cor]

# corpora.MmCorpus.serialize('corpuse.mm',corpus)#保存生成的语料
# corpus=corpora.MmCorpus('corpuse.mm')#加载

tfidf_model = models.TfidfModel(corpus)
corpus_tfidf = tfidf_model[corpus]

# 使用LSI模型进行相似度计算
lsi = models.LsiModel(corpus_tfidf)
corpus_lsi = lsi[corpus_tfidf]
similarity_lsi=similarities.Similarity('Similarity-LSI-index', corpus_lsi, num_features=400,num_best=7)
# save
# LsiModel.load(fname, mmap='r')#加载


sentence = '纳税人缴纳个人所得税'
test_cut_raw_3 = jieba_lcut(sentence, keyword)  # 去通用词
test_corpus_3 = dictionary.doc2bow(test_cut_raw_3)  # 2.转换成bow向量
test_corpus_tfidf_3 = tfidf_model[test_corpus_3]  # 3.计算tfidf值
test_corpus_lsi_3 = lsi[test_corpus_tfidf_3]  # 4.计算lsi值
#lsi.add_documents(test_corpus_lsi_3) #更新LSI的值
print(similarity_lsi[test_corpus_lsi_3])
for line in similarity_lsi[test_corpus_lsi_3]:
    print(corpora_documents[line[0]])
#print(corpora_documents[similarity_lsi[test_corpus_lsi_3][0][0]])

end = time.clock()
print('running time: %s seconds'%(end - start))
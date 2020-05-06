from urllib.request import urlopen
from bs4 import BeautifulSoup
import json

r_dict = {'set1': []}


def fetch_colors():
    for i in range(1, 15):
        html = urlopen(
            "https://www.numerosamente.it/pantone-list/fashion-and-interior-designers/" + str(i))
        soup = BeautifulSoup(html, 'lxml')

        print(i)

        for elem in soup.findAll('tr')[1:]:
            color = {}
            color['code'] = elem.findAll("td")[0].text
            rgb=(elem.findAll("td")[1].text)[4:-1]
            r,g,b=rgb.split(",")
            color['r']=r
            color['g']=g
            color['b'] = b
            color['hex'] = elem.findAll("td")[2].text
            color['name'] = elem.findAll("td")[3].text
            color['category'] = elem.findAll("td")[4].text
            r_dict['set1'].append(color)
        """
            found_same_name = False
            for elem2 in r_dict['set1']:
                if color['name'] != '' and color['name'] == elem2['name']:
                    found_same_name = True

            if not found_same_name:
                """

def writeTCH():
    with open("pantone1.tch","w",encoding="utf-8")as f:
        for elem in r_dict['set1']:
            #1200,Robison-Anton,Natural,B,240,225,195
            f.write("{code},{category},{name},A,{r},{g},{b}\n".format(code=elem["code"],category=elem["category"],name=elem["name"],r=elem["r"],g=elem["g"],b=elem["b"]))


if __name__ == "__main__":
    fetch_colors()
    """
    color={}
    color['code']="19-3909 TCX"
    color['r']="46"
    color['g']="39"
    color['b']="42"
    color['hex']="#2E272A"
    color['name']="Black Bean"
    color['category']="Fashion and Interior Designers"
    r_dict['set1'].append(color)
    """
    writeTCH()


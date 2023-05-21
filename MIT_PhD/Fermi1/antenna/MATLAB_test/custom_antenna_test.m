% Author: Huan Q. Bui
% Last modified: May 17, 2023

antenna_stl_location = '/Users/huanbui/Desktop/Repositories/huanium/MIT_PhD/Fermi1/antenna/designs/antenna_v5.stl';
c = customAntennaStl('Filename',antenna_stl_location,'Units','mm');

% create feed
feed_location = [0.0165, 0.0165, 0.001];
c.createFeed('FeedLocation',feed_location,'NumEdges',4);
refImpedance = 50;
pattern(c, 5.64e9)

% calculate impedance:
freqs = 1.0e9:5e7:10e9;
imp = impedance(c,freqs);

% createFeed(c);
% c.createFeed(feed_location,10)

import React from 'react';
import {StyleSheet, Image} from 'react-native';

const styles = StyleSheet.create({
  image: {width: 24, height: 23, opacity: 0.3},
});
export const Arrow = () => {
  return <Image style={styles.image} source={require('./arrow.png')} />;
};
